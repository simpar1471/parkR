#' Add basic Markdown formatting to strings
#'
#' These functions take a vector of input strings, and apply approriate Markdown
#' formatting for each function. I often find then useful when making tables
#' with the [gt](https://gt.rstudio.com/) package. Technically these functions
#' utilise R Markdown/pandoc-flavoured Markdown, but that's getting into the
#' weeds a bit.
#'
#' @param str A string or vector of strings to be tagged.
#' @examples
#' # Add a tag for bold
#' md_bold(str = "Text to make bold")
#'
#' # Add a tag for italics
#' md_italic(str = "Text to make italicised")
#'
#' # Apply tags to a vector of strings
#' md_code(str = c("As", "code"))
#' @returns A character vector of the same length as `str`.
#' @family string formatting functions for R Markdown
#' @name md-formatting
NULL

#' @export
#' @describeIn md-formatting Format `r md_bold("bold")` Markdown text
md_bold <- function(str) surround_with_str(str, surround = "**")

#' @export
#' @describeIn md-formatting Format `r md_italic("italic")` Markdown text
md_italic <- function(str) surround_with_str(str, surround = "*")

#' @export
#' @describeIn md-formatting Format in-line Markdown `r md_code("code")`
md_code <- function(str) surround_with_str(str, surround = "`")

#' @export
#' @param url URL to use in eventual hyperlink
#' @describeIn md-formatting Format text for a Markdown
#'   `r md_link("hyperlink", "https://roxygen2.r-lib.org/")`
md_link <- function(str, url) paste0("[", str, "](", url, ")")

#' @export
#' @describeIn md-formatting Format superscripted Markdown text
md_superscript <- function(str) surround_with_str(str, surround = "^")

#' @export
#' @describeIn md-formatting Format subscripted Markdown text
md_subscript <- function(str) surround_with_str(str, surround = "~")

#' @export
#' @describeIn md-formatting Format struck-through Markdown text
md_strikethrough <- function(str) surround_with_str(str, surround = "~~")

#' @export
#' @describeIn md-formatting Format in-line Markdown mathematics
md_math <- function(str) surround_with_str(str, surround = "$")

#' @export
#' @describeIn md-formatting Format Markdown equations with their own paragraph
md_eq <- function(str) surround_with_str(str, surround = "$$")

#' @export
#' @describeIn md-formatting Format text for a Markdown footnote
md_footnote <- function(str) paste0("^[", str, "]")

#' Apply basic LaTeX formatting commands to strings
#'
#' These functions take a vector of input strings, and insert these into
#' appropriate LaTeX commands for each function. I have found these useful when
#' preparing PDFs with R Markdown, especially in tasks like making certain
#' columns appear bold within LaTeX table output.
#'
#' @param str A string or vector of strings to be tagged.
#' @examples
#' # Add command for bold
#' tex_bold(str = "Text to make bold")
#'
#' # Add command for italics
#' tex_italic(str = "Text to make italicised")
#'
#' # Apply command to a vector of strings
#' tex_code(str = c("As", "typewriter"))
#' @returns A character vector of the same length as `str`.
#' @family string formatting functions for R Markdown
#' @name latex-formatting
NULL

#' @export
#' @describeIn latex-formatting Add a LaTex formatting command for bold text
#'   to a string
tex_bold <- function(str) tex_cmd(str, cmd = "textbf")

#' @export
#' @describeIn latex-formatting Add a LaTex formatting command for italicised
#'   text to a string
tex_italic <- function(str) tex_cmd(str, cmd = "textit")

#' @export
#' @describeIn latex-formatting Add a LaTex formatting command for
#'   teletype/typewriter/monospace text to a string
tex_code <- function(str) tex_cmd(str, cmd = "texttt")

#' @export
#' @describeIn latex-formatting Add a LaTex formatting command for
#'   superscripted text to a string
tex_superscript <- function(str) tex_cmd(str, cmd = "textsuperscript")

#' Add basic HTML tags to strings
#'
#' These functions take a vector of input strings, and tags appropriate to each
#' function. I find these most useful for inline code in R Markdown documents,
#' where I'd find manual HTML tagging more error prone.
#'
#' @param str A string or vector of strings to be tagged.
#' @examples
#' # Add a tag for bold
#' html_bold(str = "Text to make bold")
#'
#' # Add a tag for italics
#' html_italic(str = "Text to make italicised")
#'
#' # Apply tags to a vector of strings
#' html_subscript(str = c("all", "small"))
#' @returns A character vector of the same length as `str`.
#' @family string formatting functions for R Markdown
#' @name html-formatting
NULL

#' @describeIn html-formatting Add HTML strong (`r html_bold("bold")`) tag
#' @export
html_bold <- function(str) html_tag(str, tag = "strong")

#' @describeIn html-formatting Add HTML emphasis (`r html_italic("italic")`) tag
#' @export
html_italic <- function(str) html_tag(str, tag = "em")

#' @describeIn html-formatting Add HTML `r html_superscript("superscript")` tag
#' @export
html_superscript <- function(str) html_tag(str, tag = "sup")

#' @describeIn html-formatting Add HTML `r html_subscript("subscript")` tag
#' @export
html_subscript <- function(str) html_tag(str, tag = "sub")

#' @describeIn html-formatting Add HTML `r html_strikethrough("strikethrough")` tag
#' @export
html_strikethrough <- function(str) html_tag(str, tag = "del")

# Internal functions -----------------------------------------------------------
#' Add an HTML tag to a string
#' @param str Character vector to edit.
#' @param tag A character vector of length 1 defining the HTML tags to add
#'    around the values in `str`.
#' @returns A character vector the same length as `str`.
#' @noRd
html_tag <- function(str, tag) {
    paste0("<", tag, ">", str, "</", tag, ">")
}

#' Surround a string with characters
#' @param str Character vector to edit.
#' @param surround A character vector of length 1 to add around `str`.
#' @returns A character vector the same length as `str`.
#' @noRd
surround_with_str <- function(str, surround) paste0(surround, str, surround)

#' Apply a latex command to a vector of strings
#' @param str Character vector to edit.
#' @param cmd A character vector of length 1 defining the LaTeX fornattubg
#'    command to add around the values in `str`.
#' @returns A character vector the same length as `str`.
#' @noRd
tex_cmd <- function(str, cmd) paste0("\\", cmd, "{", str, "}")