context("Test corr_plus")

test_that("Test valid data format",{
  single_x <- c(11)
  single_y <- c(22)
  multi_x <- c(1,2,3,4,5)
  multi_y <- c(6,7,8,9,10)
  multi_y_plus <- c(6,7,8,9,10,11)
  mix_type_x <-  c(1,"2",3,4,5)
  mix_type_y <-  c(1,2,3+2i,4,5)

  expect_error(corr_plus(1,2,3,4)) # return ERROR if the input is not a vector
  expect_error(corr_plus(mix_type_x, mix_type_y)) # expect ERROR if the input are not numeric
  expect_error(corr_plus(mix_type_x, multi_y_plus)) # expect ERROR if the length of two vectors are different
  expect_true(is.na(corr_plus(single_x, single_y))) # expect NA if the length of both vectors are one
  expect_length(corr_plus(multi_x, multi_y), 1) # expect TRUE if the length of the output is one
})

test_that("Test the correctness of corr_plus",{
  zeros_x <- c(0,0,0,0)
  multi_x <- c(1,-2,3,-4)
  multi_y <- c(-6,7,-8,9)
  large_x <- c(1000,-2000,3000)
  large_y <- c(-6000,7000,-8000)

  expect_true(is.na(corr_plus(zeros_x, multi_x))) # expect TRUE if one of the vectors contains only zeros
  expect_equal(corr_plus(multi_x, multi_y),  -0.9694164) # test if two valid inputs contain some pos and neg values and return the correct output
  expect_equal(corr_plus(large_x, large_y),  -0.9595082) # test if two valid inputs contain some large pos and large neg values and return the correct output
})

test_that("Test the ability of handling missing values", {
  missing_x <- c(1,2,3,4,5,6,7, NA)
  missing_y <- c(2,3,4,5,NA,1,3,4)

  expect_equal(corr_plus(missing_x, missing_x), 1) # test if the function handles the missing values and return the correct output
  expect_equal(corr_plus(missing_x, missing_y), -0.1220935) # test if the function handles the missing values and return the correct output
})
