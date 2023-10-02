test_that("Markdown formatting works", {
  expect_equal(md_bold(str = "test"), expected = "**test**")
  expect_equal(md_italic(str = "test"), expected = "*test*")
  expect_equal(md_code(str = "test"), expected = "`test`")
  expect_equal(md_link(str = "test", url = "link"), expected = "[test](link)")
  expect_equal(md_superscript(str = "test"), expected = "^test^")
  expect_equal(md_subscript(str = "test"), expected = "~test~")
  expect_equal(md_strikethrough(str = "test"), expected = "~~test~~")
  expect_equal(md_math(str = "test"), expected = "$test$")
  expect_equal(md_eq(str = "test"), expected = "$$test$$")
  expect_equal(md_footnote(str = "test"), expected = "^[test]")
})

test_that("LaTeX formatting works", {
  expect_equal(tex_bold(str = "test"), expected = "\\textbf{test}")
  expect_equal(tex_italic(str = "test"), expected = "\\textit{test}")
  expect_equal(tex_code(str = "test"), expected = "\\texttt{test}")
  expect_equal(tex_superscript(str = "test"), expected = "\\textsuperscript{test}")
})

test_that("HTML formatting works", {
  expect_equal(html_bold(str = "test"), expected = "<strong>test</strong>")
  expect_equal(html_italic(str = "test"), expected = "<em>test</em>")
  expect_equal(html_superscript(str = "test"), expected = "<sup>test</sup>")
  expect_equal(html_subscript(str = "test"), expected = "<sub>test</sub>")
  expect_equal(html_strikethrough(str = "test"), expected = "<del>test</del>")
})
