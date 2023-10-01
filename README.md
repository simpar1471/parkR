
<!-- README.md is generated from README.Rmd. Please edit that file -->

# parkR: Functions I find helpful in R

<!-- badges: start -->
<!-- badges: end -->

The parkR package contains functions which I find useful as I’m working
in R, especially when making reports. Included are some functions for
quickly setting up HTML notebooks with `{rmarkdown}` and `{bookdown}`,
and some helpful functions for applying Markdown, LaTeX commands, or
HTML tags to text data in R.

## Installation

You can install the development version of parkR using the `devtools`
package:

``` r
devtools::install_github(repo = "simpar1471/parkR")
```

## Useful functions

### `use_rmd_html()`

This function generates a main `.rmd` file, either with or without
children, and sets some nice defaults for its use. This `.rmd` file will
knit to HTML.

### `use_bibliography()`

This function generates a folder containing a `.bib` and `.csl` file for
including citations in R Markdown documents. I’ve written this as I
often need to cite sources in my work, but the basic R Markdown project
setup in PyCharm does not include these features.

### `use_rmd_sections()`

This function generates a folder containing child `.rmd` files. These
can be included in the parent `rmd.` file using the knitr chunk option
`child = ...` and a suitable use of `base::list.files()`.

## Plans for updates

- Add `use_rmd_pdf()`, `use_rmd_powerpoint()` and friends to automate
  these tasks as well.
- Increase coverage of `{testthat}`-based unit testing.
- Add a function for setting my preferred `{ggplot2}`
- Write out the `use_hex_sticker()` function, for use during package
  development.

## Feedback

Feedback is greatly appreciated, and should be done on the [GitHub
issues page](https://www.github.com/parkR/issues). Please be kind.
