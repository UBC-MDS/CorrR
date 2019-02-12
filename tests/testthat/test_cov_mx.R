context("Test cov_mx")

test_that("Test valid data format",{
  x <- matrix(c(-2,-1,0,1,2,1.5,2,0,1,2,4,2,0,1,2), 5)
  nrows <- dim(x)[1]
  ncols <- dim(x)[2]
  single_row_x <- matrix(c(-2,-1,0,1,2), 1, 5)
  char_x <- as.character(x)

  expect_true(is.na(cov_mx(single_row_x)[1,1])) # expect NA if we have a single row in the input matrix
  expect_equal(dim(cov_mx(x))[1], ncols) # expect the covariance matrix has the same number of rows as the number of features of input matrix
  expect_equal(dim(cov_mx(x))[2], ncols) #  expect the covariance matrix has the same number of cols as the number of features of input matrix
  expect_true(is.matrix(cov_mx(x)))# expect a matrix output
  expect_error(cov_mx(char_x)) #  expect ERROR if the input matrix is not numeric
})

test_that("Test the correctness of the function cov_mc", {
  good_x <- matrix(c(-2,-1,0,1,2,1.5,2,0,1,2,4,2,0,1,2), 5)
  nrows <- dim(x)[1]
  ncols <- dim(x)[2]

  good_cov_result <- cov_mx(good_x)

  for (i in 1:nrows){
    for(j in 1:ncols){
      expect_equal(good_cov_result[i,j], cov(good_x[,i], good_x[,j])) # expect TRUE for all covariance in the matrix
    }
  }

  # test for inf value in a matrix
  inf_matrix <- matrix(c(0.1, 0.03, Inf, 0.4, 0.08, 0.22, 0.15, 0.55), 4)
  nrows <- dim(x)[1]
  ncols <- dim(x)[2]
  # implements cov_mx for testting
  cov_result <- cov_mx(inf_matrix[!rowSums(!is.finite(inf_matrix)),])
  # Check isf cov results matches with cov_mx
  for (i in 1: nrows){
    for (j in ncols){
      expect_equal(cov_result[i ,j],
                   cov(
                     inf_matrix[!rowSums(!is.finite(inf_matrix)),][, i],
                     inf_matrix[!rowSums(!is.finite(inf_matrix)),][, j])
      )
    }
  }







})


test_that("Test the ability of handling missing values", {
  bad_x <- matrix(c(-2,-1,0,NA,2,1.5,2,NA,1,2,4,2,0,1,2), 5)
  nrows <- dim(x)[1]
  ncols <- dim(x)[2]

  cov_by_r <- cov(bad_x, use = "complete.obs")
  cov_by_corr <- cov_mx(bad_x)

  expect_true(is.matrix(cov_by_r)
             && is.matrix(cov_by_corr)
             && dim(cov_by_r) == dim(cov_by_corr)
             && all(cov_by_r == cov_by_corr))

  bad_matrix <- matrix(c(0.1, 0.03, NA, 0.4, 0.08, 0.22, 0.15, 0.55), 4)
  nrow_2 <- dim(x)[1]
  ncols_2 <- dim(x)[2]

  cov_with_r <- cov(bad_matrix, use = "complete.obs")
  cov_with_corr <- cov_mx(bad_matrix)

  expect_true(is.matrix(cov_with_corr)
              && is.matrix(cov_with_corr)
              && dim(cov_with_r) == dim(cov_with_corr)
              && all(cov_with_r == cov_with_corr))


})





