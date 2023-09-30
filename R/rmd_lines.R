#' Generate lines for a simple R Markdown child document
#' @param child_number Which section is this? Determines header and body text.
#' @keywords internal
rmd_lines_child <- function(child_number) {
  c(paste0("# Section ", child_number),
    ifelse(child_number == 0,
           yes = "Use this 0th child document for setup that is too long for the parent .rmd file.",
           no = "Use this child document and those after it to section your work.")
    )
}

#' Generate lines for an R Markdown document without children
#' @inheritParams rmd_lines_yaml
#' @keywords internal
rmd_lines_notparent <- function(title, author, date = Sys.Date(), bib_path, csl_path) {
  c(rmd_lines_yaml(title, author, date = Sys.Date(), bib_path, csl_path),
    "",
    rmd_lines_citation_reminder(),
    "",
    "# References",
    ""
  )
}

#' Generate lines for an R Markdown document with children
#' @inheritParams rmd_lines_yaml
#' @keywords internal
rmd_lines_parent <- function(title,
                             author,
                             date = Sys.Date(),
                             bib_path,
                             csl_path,
                             child_dir,
                             child_prefix) {
  child_regex <- paste0("^", child_prefix, "[:digit:].*rmd$")

  c(rmd_lines_yaml(title, author, date = Sys.Date(), bib_path, csl_path),
    "",
    rmd_lines_setup(),
    "",
    rmd_lines_citation_reminder(),
    "",
    paste0("```{r run_children, child = file.path('", child_dir, "',
            stringr::str_subset(list.files('", child_dir, "'),
            pattern = '", child_regex, "'))}"),
    "```",
    "",
    "# References",
    "")
}

#' Generate lines for YAML intro to an R Markdown document
#' @param title Document title.
#' @param author Document author.
#' @param date Document date. Default = `Sys.Date()`, which will update whenever
#' the document is knitted.
#' @param bib_path The file path for the bibliography file.
#' @param csl_path The file path for the CSL file used to generate citations.
#' @returns Character vector with lines corresponding to YAML heading for R
#' Markdown documents.
#' @keywords internal
rmd_lines_yaml <- function(title = "",
                           author = "",
                           date = Sys.Date(),
                           bib_path = "bibliography/references.bib",
                           csl_path = "bibliography/elsevier-harvard.csl") {
  yaml_field <- function(field, value) paste0(field, ": ", value)
  c('---',
    yaml_field(field = "title", title),
    yaml_field(field = "author", author),
    yaml_field(field = "date", date),
    'output:',
    '  bookdown::html_document2:',
    '    number_sections: false',
    '    toc: true',
    '    toc_float: true',
    '    toc_depth: 2',
    '    toc_collapsed: true',
    '    theme: readable',
    yaml_field(field = "bibliography", bib_path),
    yaml_field(field = "csl", csl_path),
    '---')
}

#' Generate lines for a basic R Markdown setup code block
#' @keywords internal
rmd_lines_setup <- function() {
  c("```{r setup, include = FALSE}",
    "knitr::opts_chunk$set(",
    "        class.source = 'fold-hide',",
    "        dev.args = list(png = list(type = 'cairo'))",
    ")",
    "```")
}

#' Generate lines which describe simple how to cite in R Markdown
#' @returns 2-length character vector describing how to cite in R Markdown.
#' @keywords internal
rmd_lines_citation_reminder <- function() {
  c("You can cite sources with square brackets, like `[@rlang2023]`.",
    "This outputs a citation like so: [@rlang2023].")
}