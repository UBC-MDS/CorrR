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
  #if(is.null(x)){
  #   stop("Input cannot be empty.")
  #  }

  # check whether input vector are valid or not
  tryCatch(
    {
      sample(x,1)
    },
    error=function(error_message) {
      message("'x' cannot be empty")
      message(error_message)
    }
  )



  # the input data should be numeric
  if(!(is.numeric(x) || is.logical(x))) stop("'x' must be numeric.")
  stopifnot(is.atomic(x))

  # return NA if The length of input equal to 1
  if (length(x) == 1L){
    return (NA)
  }

  if (dim(x)[1] == 1 | dim(x)[2] == 1){
    return (NA)
  }

  # remove the rows that missing value or finite are present
  z <- x[!rowSums(!is.finite(x)), ]
  z <- stats::na.omit(z)

  # check if the matrix is empty after removing inf and nan
  if (!length(z)){
    stop("Input cannot be empty.")
  }

  # calculate covariance matrix
  X <-  z
  N <- nrow(X)
  X <- sweep(X, 2, colMeans(z), `-`)
  dot_product <- t(X) %*% Conj(X)
  Z <- dot_product / (N-1)

  return(Z)

}
