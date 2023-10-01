#' Download a CSL file from the CSL file repositories at either Zotero or
#' GitHub
#' @description Citation Style Language (CSL) files are used to control
#' referencing styles by a range of softwares, including
#' [citeproc](https://github.com/jgm/citeproc), the default citation processor
#' in [bookdown](https://bookdown.org/yihui/bookdown/citations.html).
#' @param csl_style A CSL style specification from the
#' [Zotero Style Repository](https://www.zotero.org/styles) or [GitHub CSL
#' repository](https://github.com/citation-style-language/styles). Should be the
#' `.csl` file name without the file extension, e.g. for `my-csl-style.csl`,
#' provide "my-csl-style". Default = `"elsevier-harvard"`.
#' @param csl_file A file path for `download_csl` to download to. Default =
#' `tempfile(fileext = ".csl")`.
#' @param zotero_first If `TRUE`, the function will attempt to download from the
#' Zotero Style Repository first. If `FALSE`, the function will attempt to
#' download from GitHub first. Default = `TRUE`.
#' @examples
#' \dontrun{
#' download_csl(csl_style = "elsevier_harvard")
#' }
#' @returns If the download was successful, a one-length character vector
#' with the path of the downloaded `.csl` file. If unsuccessful, stops with
#' error.
#' @export
download_csl <- function(csl_style = "elsevier-harvard",
                         csl_file = tempfile(fileext = ".csl"),
                         zotero_first = TRUE) {
  zotero_url <- paste0("https://www.zotero.org/styles/", csl_style)
  github_url <- paste0(
    "https://raw.githubusercontent.com/citation-style-language/styles/master/",
    csl_style, ".csl")

  silent_dl_attempt <- function(url, file) {
      try(curl::curl_download(url, file))
  }
  if (zotero_first) {
    silent_dl_attempt(zotero_url, csl_file)
  } else silent_dl_attempt(github_url, csl_file)

  if (file.exists(csl_file)) {
    return(csl_file)
  }

  if (zotero_first) {
    silent_dl_attempt(github_url, csl_file)
  } else silent_dl_attempt(zotero_url, csl_file)

  if (file.exists(csl_file)) {
    return(csl_file)
  }

  cli::cli_abort(
    message =
      paste("{.fn parkR::download_csl} could not find the CSL style",
        "{.val {csl_style}}. Look on the",
        "{.href [Zotero Style Repository](https://www.zotero.org/styles)}",
        "or {.href [GitHub CSL repository](https://github.com/citation-style-language/styles)}",
        "for a valid style name."))
}


#' Is a directory an R package?
#'
#' @param base_path Directory to test with
#' [rprojroot::find_package_root_file()]. Default = [usethis::proj_get()].
#' @returns Logical value based on whether `base_path` was an R package.
#' @keywords internal
is_package <- function(base_path = usethis::proj_get()) {
  res <- tryCatch(rprojroot::find_package_root_file(path = base_path), error = function(e) NULL)
  !is.null(res)
}


#' Create directory or warn user if directory already exists
#' @param dir Directory to attempt to create. User will be warned if the
#' directory already exists.
#' @keywords internal
create_dir_or_warn <- function(dir) {
  if (!dir.exists(dir))  {
    dir.create(dir)
    cli::cli_alert_success("Created the directory {.file '{dir}}'.")
  } else {
    cli::cli_warn("A directory called {.file '{dir}'} already exists.")
  }
}

#' Construct a glue expression using square brackets
#' @description Wrapper around [glue::glue()], that uses square brackets instead
#' of the usual curly braces. Can be useful when substituting R expressions in
#' strings for LaTeX code, where curly braces are often used for formatting.
#' @param ... Unnamed arguments are taken to be expression string(s) to format.
#' Multiple inputs are concatenated together before formatting.
#' Named arguments are taken to be temporary variables available for
#' substitution.
#' @seealso [glue::glue()], which this function wraps.
#' @examples
#' italics_str <- "italics"
#'
#' # Will not provide a well-formatted string
#' glue::glue("I want this in \\textit{{italics_str}}!")
#'
#' # Will give a correctly formatted result
#' sqglue("I want this in \\textit{[italics_str]}!")
#' @returns A one-length character vector.
#' @export
sqglue <- function(...) glue::glue(..., .open = "[", .close = "]")