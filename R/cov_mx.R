#' Covariance matrix
#'
#' `cov_mx` function calculates the covariance matrix of the two
#'  variables and automatically deals with the missing value
#'
#' @usage cov_mx(x)
#'
#' @param x a matrix that contains one or more than one random variable
#'
#' @return z matrix that contains the covariance between random
#' variables in the input matrix
#'
#' @export
#'
#' @examples cov_mx(matrix(c(1, 2, NA, 4, 5, 6, 7, 8), 4))
cov_mx <- function(x){

  # check whether input vectors are valid or not
  if(is.null(x)){
    stop("Input cannot be empty.")
  }

  # the input data should be numeric
  if(!(is.numeric(x) || is.logical(x))) stop("'x' must be numeric.")
  stopifnot(is.atomic(x))

   # return ERROR if the inputs are empty
  if(length(x) == 0L){
    stop("'x' must be non-empty.")
  }

  # return NA if The length of input equal to 1
  else if (length(x) == 1L){
    return (NA)
  }

  # return error if matrix is not 2D
  if (dim(x)[2] == 1){
    stop("'x' must be 2D matrix")
  }
  else if (dim(x)[2] > 2){
    stop("'x' must be 2D matrix")
  }





}
