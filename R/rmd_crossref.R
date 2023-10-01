#' Format an R Markdown cross-reference for tables, figures, or equations
#' @param type The type of environment being referenced. Can be one of `"fig"`,
#' `"tab"`, or `"eq"`.
#' @inheritParams rmd_cref_tab
#' @keywords internal
rmd_crossref <- function(type = "", label) {
  knitr::asis_output(paste0(type, ":", label))
}

#' Construct bookdown cross-references for tables, figures, or equations
#' @param label The chunk label for your figure, table or equation to
#' cross-reference.
#' @note This will only work in a `{bookdown}` document, such as those produced
#' by `use_rmd_html()`.
#' @examples
#' rmd_cref_tab(label = "life-by-sex-table")
#' rmd_cref_fig(label = "life-by-sex-figure")
#' rmd_cref_eq(label = "life-by-sex-equation")
#' @export
rmd_cref_tab <- function(label) rmd_crossref(type = "tab", label)

#' @rdname rmd_cref_tab
#' @export
rmd_cref_fig <- function(label) rmd_crossref(type = "fig", label)

#' @rdname rmd_cref_tab
#' @export
rmd_cref_eq <- function(label) rmd_crossref(type = "eq", label)
