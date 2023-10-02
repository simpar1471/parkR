test_that(desc = "R Markdown cross-referecing commands work", {
  test_str <- paste0(sample(c(LETTERS, letters), size = 10, replace = TRUE),
                     collapse = "")
  expect_equal(rmd_cref_tab(label = test_str),
               expected = knitr::asis_output(sqglue("tab:[test_str]")))
  expect_equal(rmd_cref_fig(label = test_str),
               expected = knitr::asis_output(sqglue("fig:[test_str]")))
  expect_equal(rmd_cref_eq(label =  test_str),
               expected = knitr::asis_output(sqglue("eq:[test_str]")))
})