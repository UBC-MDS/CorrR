context("Test corr_plus")

test_test("Test valid data format",{
  single_x <- c(11)
  single_y <- c(22)
  multi_x <- c(1,2,3,4,5)
  multi_y <- c(6,7,8,9,10)

  expect_error(corr_plus(1,2,3,4)) # return error if the input is not a vector
  expect_true(is.na(corr_plus(single_x, single_y))) # expect NA if the length of both vectors are one
  expect_length(corr_plus(multi_x, multi_y), 1) # expect true if the length of the output is one
})
