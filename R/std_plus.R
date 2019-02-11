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

  # check whether a input vector is valid
  if(is.null(x)){# The input vector cannot be null
    stop("The input cannot be empty")
  }
  if(is.character(x) || is.complex(x)){ # the input type cannot be character, complex
    return (NA)
  }
  if (length(x) <= 1L){ # The length of input should be greater than 1
    return (NA)
  }

  # transform x which is coercible to one
  x <- if (is.vector(x) || is.factor(x)) x else as.double(x)

  # treat infinite values as missing values
  is_inf <- is.infinite(x)
  x <- x[!is_inf]

  # remove missing values
  x <- x[!is.na(x)]

  # calculate standard deviation
  sd_value <- sqrt(sum((x-mean(x))^2/(length(x)-1)))
  return (sd_value)
}
