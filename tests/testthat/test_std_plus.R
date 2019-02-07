context("Test std_plus")

test_that("fbind binds factor (or character)", {
  x <- c('a', 'b')
  x_fact <- factor(x)
  y <- c('c', 'd')
  z <- factor(c('a', 'b', 'c', 'd'))

  expect_identical(std_plus(x, y), z)
  expect_identical(std_plus(x_fact, y), z)
})
