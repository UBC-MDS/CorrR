#' Standard Deviation
#'
#' `std_plus` function calculates the standard deviation of the values in a numeric vector. It is capable of computing
#' standard deviation when the vector contains missing values and inifinite values by automatically removing them.
#'
#' @usage std_plus(x)
#'
#' @param x (numeric) a numeric vector
#'
#' @return the value of standard deviation of the input data
#' @export
#'
#' @examples std_plus(c(1,2,3,4,5))
#' @examples std_plus(c(1,2,3,NA,5))
std_plus <- function(x) {

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


  if(!(is.numeric(x) || is.logical(x))){ # the input data should be numeric
    return (NA)
  }
  if (length(x) <= 1L){ # The length of input should be greater than 1
    return (NA)
  }

  # transform x which is coercible to one
  x <- if (is.vector(x) || is.factor(x)) x else as.double(x)

  # treat infinite values as missing values and remove them
  x <- x[!is.infinite(x)]

  # remove missing values
  x <- x[!is.na(x)]

  # calculate standard deviation
  sd_value <- sqrt(sum((x-mean(x))^2/(length(x)-1)))
  return (sd_value)
}
