context("Test cov_mx")

test_that("Test valid data format",{
  x <- matrix(c(-2,-1,0,1,2,1.5,2,0,1,2,4,2,0,1,2), 5)
  nrows <- dim(x)[1]
  ncols <- dim(x)[2]
  single_row_x <- matrix(c(-2,-1,0,1,2), 1, 5)
  char_x <- as.character(x)

  # expect NA if we have a single row in the input matrix
  expect_true(is.na(cov_mx(single_row_x)))
  expect_true(is.na(cov_mx(matrix(c(1)))))
  # expect the covariance matrix has the same number of rows as the number of features of input matrix
  expect_equal(dim(cov_mx(x))[1], ncols)
  # expect the covariance matrix has the same number of cols as the number of features of input matrix
  expect_equal(dim(cov_mx(x))[2], ncols)
  # expect a matrix output
  expect_true(is.matrix(cov_mx(x)))
  # expect ERROR if the input matrix is not numeric
  expect_error(cov_mx(char_x))
  # expect ERROR if the input matrix is NULL
  expect_error(cov_mx(NULL))
})

test_that("Test the correctness of the function cov_mx", {
  good_x <- matrix(c(-2,-1,0,1,2,1.5,2,0,1,2,4,2,0,1,2), 5)
  nrows <- dim(good_x)[1]
  ncols <- dim(good_x)[2]

  good_cov_result <- cov_mx(good_x)

  # expect TRUE for all covariance in the matrix
  expect_equal(good_cov_result, cov(good_x))

})


test_that("Test the ability of handling missing values", {
  bad_x <- matrix(c(-2,-1,0,NA,2,1.5,2,NA,1,2,4,2,0,1,2), 5)
  nrows <- dim(bad_x)[1]
  ncols <- dim(bad_x)[2]

  # covariance matrix with R base
  cov_by_r <- cov(bad_x, use = "complete.obs")
  #covariance matrix with CorrR
  cov_by_corr <- cov_mx(bad_x)

  # check if the output is matrix and dimentions are the same
  expect_true(is.matrix(cov_by_r)
             && is.matrix(cov_by_corr)
             && dim(cov_by_r) == dim(cov_by_corr))
  expect_equal(cov_by_corr, cov_by_r)

  # create a matrix with NAs
  bad_matrix <- matrix(c(0.1, 0.03, NA, 0.4, 0.08, 0.22, 0.15, 0.55), 4)
  nrow_2 <- dim(bad_matrix)[1]
  ncols_2 <- dim(bad_matrix)[2]

  # covarience matrix with R base
  cov_with_r <- cov(bad_matrix, use = "complete.obs")
  # covarience matrix with CorrR
  cov_with_corr <- cov_mx(bad_matrix)

  # Check if the output is matrix and dimentions are the same
  expect_true(is.matrix(cov_with_corr)
              && is.matrix(cov_with_corr)
              && dim(cov_with_r) == dim(cov_with_corr)
              && all(cov_with_r == cov_with_corr))

  # create a matrix a full of na and inf
  bad_x2 <- matrix(c(NA, NA, Inf, Inf), 2)
  expect_error(cov_mx(bad_x2))
})



test_that("Test the ability of handling finite values", {

    # test for inf value in a matrix
    inf_matrix <- matrix(c(0.1, 0.03, Inf, 0.4, 0.08, 0.22, 0.15, 0.55), 4)
    nrows <- dim(inf_matrix)[1]
    ncols <- dim(inf_matrix)[2]

    # implements cov_mx for testting
    cov_result <- cov_mx(inf_matrix[!rowSums(!is.finite(inf_matrix)),])

    # Check if covarience results from R base matches with CorrR
    expect_equal(cov_result,
                     cov(
                       inf_matrix[!rowSums(!is.finite(inf_matrix)),]))

    })







