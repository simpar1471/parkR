#' Construct bookdown cross-references for tables, figures, or equations
#'
#' These functions each use a code chunk label to cross-reference, according to
#' the format specifed for bookdown [cross-referencing](https://bookdown.org/yihui/rmarkdown-cookbook/cross-ref.html).
#'
#' @param label The chunk label for your table, figure, or equation.
#' @note This will only work in a bookdown-style output, like
#'    [bookdown::html_document2()] or [bookdown::pdf_document2()].
#' @examples
#' rmd_cref_tab(label = "life-by-sex-table")
#'
#' rmd_cref_fig(label = "life-by-sex-figure")
#'
#' rmd_cref_eq(label = "life-by-sex-equation")
#' @name rmd-crossref
NULL

#' @export
#' @describeIn rmd-crossref Cross-reference a table in R Markdown documents
rmd_cref_tab <- function(label) rmd_crossref(type = "tab", label)


#' @export
#' @describeIn rmd-crossref Cross-reference a figure in R Markdown documents
rmd_cref_fig <- function(label) rmd_crossref(type = "fig", label)

#' @export
#' @describeIn rmd-crossref Cross-reference an equation in R Markdown documents
rmd_cref_eq <- function(label) rmd_crossref(type = "eq", label)

#' Format a [bookdown] cross-reference for tables, figures, or equations
#' @param type The type of environment being referenced. Can be one of `"fig"`,
#'    `"tab"`, or `"eq"`.
#' @param label The chunk label for your figure, table or equation to
#'    cross-reference.
#' @noRd
rmd_crossref <- function(type = "", label) {
  knitr::asis_output(paste0(type, ":", label))
}