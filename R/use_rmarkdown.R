#' Setup an R Markdown files which will knit to HTML with my preferred defaults
#' @description Sets up folders/files in the working directory for an R Markdown
#' document which will knit to HTML.
#' @param rmd_file Name of the main `.rmd` document, which will have YAML for
#' a [bookdown::html_document2()] output. If `child_dir` is specified, this file
#' will contain a code chunk for including child `.rmd` files.
#' @param bib_dir Name of directory which will contain `.bib` and `.csl` file
#' for referencing. Default = `"bibliography"`.
#' @param bib_file File name for `.bib` file in `bib_dir`. Default =
#' `"references.bib"`.
#' @param child_dir If not `NULL`, specifies the name of the directory which
#' will contain child `.rmd` documents, which will be created by
#' `use_rmd_sections()`. Default = `NULL`.
#' @param child_prefix The file name prefix for child `.rmd` files in the folder
#' specified by `child_dir`. Default = "sec".
#' @param overwrite Logical value denoting whether files should be overwritten
#' automatically. If `FALSE`, the function will ask before overwriting. If
#' `TRUE`, the function will ask, then overwrite. Default = FALSE.
#' @inheritParams download_csl
#' @export
use_rmd_html <- function(rmd_file = "untitled.rmd",
                         bib_dir = "bibliography",
                         bib_file = "references.bib",
                         csl_style = "elsevier-harvard",
                         child_dir = NULL,
                         child_prefix = "sec",
                         overwrite = FALSE) {
  if (!rlang::is_interactive()) {
    cli::cli_abort(message = c("{.fun parkR::rmarkdown_html} can only be ",
                               "used in interactive sessions."))
  }
  # Write bibliography files
  use_bibliography(bib_dir, bib_file, csl_style, overwrite = overwrite)

  # Write .rmd child documents if wanted, then add parent/non-parent .rmd file
  if (!is.null(child_dir)) {
    use_rmd_children(child_dir, n = 2, child_prefix, overwrite)
    usethis::write_over(
      rmd_file,
      lines = rmd_lines_parent(
        title = "Working title", author = "Unknown Author",
        bib_path = file.path(bib_dir, bib_file),
        csl_path = file.path(bib_dir, paste0(csl_style, ".csl")),
        child_dir = child_dir, child_prefix = child_prefix
    ))
  } else {
    usethis::write_over(
      rmd_file,
      lines = rmd_lines_notparent(
        title = "Working title", author = "Unknown Author",
        bib_path = file.path(bib_dir, bib_file),
        csl_path = file.path(bib_dir, paste0(csl_style, ".csl"))
    ))
  }
}

#' Generate a directory with a bibliography and CSL file.
#' @param bib_dir Name of new directory.
#' @param bib_file Name of new `.bib` file.
#' @param overwrite Should the function overwrite files without asking? Default
#' = `FALSE`.
#' @inheritParams download_csl
#' @export
use_bibliography <- function(bib_dir = "bibliography",
                             bib_file = "references.bib",
                             csl_style = "elsevier-harvard",
                             overwrite = FALSE) {
  bib_path <- file.path(bib_dir, bib_file)
  csl_file <- paste0(csl_style, ".csl")
  csl_path <- file.path(bib_dir, csl_file)
  create_dir_or_warn(bib_dir)
  csl_temp <- download_csl(csl_style = csl_style)
  r_bibtex <- utils::citation(package = "base") |>
    utils::toBibtex() |>
    unname() |>
    unclass()
  bib_lines <- c(gsub(x = r_bibtex,
                      pattern = "\\{,$",
                      replacement = "\\{rlang2023,"),
                 "")
  usethis::write_over(bib_path, lines = bib_lines, overwrite = TRUE)
  usethis::write_over(csl_path, lines = readLines(csl_temp), overwrite = TRUE)
  unlink(csl_temp)
}

#' Generate some R Markdown child documents in a specific folder
#' @param child_dir Directory in which to write children `.rmd` documents.
#' Default = `"sections"`.
#' @param n Number of child documents to generate. Default = `2`.
#' @param child_prefix Prefix for child documents. Default = "sec".
#' @param overwrite If TRUE, do not ask before overwriting existing files.
#' Default = FALSE.
#' @export
use_rmd_children <- function(child_dir = "sections",
                             n = 2,
                             child_prefix = "sec",
                             overwrite = FALSE) {
  children <- 0:(n-1)
  child_paths <- file.path(child_dir, paste0(child_prefix, children,
                                             "-untitled.rmd"))
  create_dir_or_warn(child_dir)
  purrr::walk2(children,
               child_paths,
               .f = \(child_int, child_path) {
                 usethis::write_over(child_path,
                                     lines = rmd_lines_child(child_number = child_int),
                                     overwrite = overwrite)
               })
}

