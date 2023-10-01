#' Add an HTML tag to a string
#' @keywords internal
html_tag <- function(str, tag) {
    paste0("<", tag, ">", str, "</", tag, ">")
}

#' Add basic HTML tags to strings
#'
#' @description These functions take a vector of input strings, and apply the
#' approriate tag for each function.
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
#' @returns A character vector with HTML tags applied, the same length as `str`.
#' @export
html_bold <- function(str) html_tag(str, tag = "strong")

#' @rdname html_bold
#' @export
html_italic <- function(str) html_tag(str, tag = "em")

#' @rdname html_bold
#' @export
html_superscript <- function(str) html_tag(str, tag = "sup")

#' @rdname html_bold
#' @export
html_subscript <- function(str) html_tag(str, tag = "sub")

#' @rdname html_bold
#' @export
html_strikethrough <- function(str) html_tag(str, tag = "del")

#' Surround a string with characters
#' @keywords internal
surround_with_str <- function(str, surround) paste0(surround, str, surround)

#' Add basic Markdown formatting to strings
#'
#' @description These functions take a vector of input strings, and apply the
#' approriate Markdown formatting for each function. I often find then useful
#' when making tables with the `{gt}` package.
#' @param str A string or vector of strings to be tagged.
#' @examples
#' # Add a tag for bold
#' md_bold(str = "Text to make bold")
#'
#' # Add a tag for italics
#' md_italic(str = "Text to make italicised")
#'
#' # Apply tags to a vector of strings
#' md_code(str = c("all", "small"))
#' @returns A character vector with HTML tags applied, the same length as `str`.
#' @export
md_bold <- function(str) surround_with_str(str, surround = "**")

#' @export
#' @rdname md_bold
md_italic <- function(str) surround_with_str(str, surround = "*")

#' @export
#' @rdname md_bold
md_code <- function(str) surround_with_str(str, surround = "`")

#' @export
#' @rdname md_bold
md_superscript <- function(str) surround_with_str(str, surround = "^")

#' @export
#' @rdname md_bold
md_subscript <- function(str) surround_with_str(str, surround = "~")

#' @export
#' @rdname md_bold
md_footnote <- function(str) paste0("^[", str, "]")

#' @export
#' @rdname md_bold
md_math <- function(str) surround_with_str(str, surround = "$")

#' @export
#' @rdname md_bold
md_eq <- function(str) surround_with_str(str, surround = "$$")


#' Apply a latex command to a vector of strings
#' @keywords internal
tex_cmd <- function(str, cmd) paste0("\\", cmd, "{", str, "}")

#' Apply basic LaTeX formatting commands to strings
#'
#' @description These functions take a vector of input strings, and apply the
#' approriate LaTeX commands for each function. I have found these useful when
#' preparing PDFs with R Markdown.
#' @param str A string or vector of strings to be tagged.
#' @examples
#' # Add command for bold
#' tex_bold(str = "Text to make bold")
#'
#' # Add command for italics
#' tex_italic(str = "Text to make italicised")
#'
#' # Apply command to a vector of strings
#' tex_code(str = c("all", "small"))
#' @returns A character vector with HTML tags applied, the same length as `str`.
#' @export
tex_bold <- function(str) tex_cmd(str, cmd = "textbf")

#' @export
#' @rdname tex_bold
tex_italic <- function(str) tex_cmd(str, cmd = "textit")

#' @export
#' @rdname tex_bold
tex_superscript <- function(str) tex_cmd(str, cmd = "textsuperscript")

#' @rdname tex_bold
#' @export
tex_code <- function(str) tex_cmd(str, cmd = "texttt")