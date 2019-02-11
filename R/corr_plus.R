#' Correlation
#'
#' `corr_plus` function calculates the Pearson correlation coefficient between
#' two variables using complete case analysis that excludes all observations
#' that have NA for at least one variable.
#'
#' @usage corr_plus(x, y)
#'
#' @param x a numeric vector
#' @param y a numeric vector
#'
#' @return the value of standard deviation of the input data
#' @export
#'
#' @examples corr_plus(c(1,2,3,4,5), c(1,2,3,NA,5))
corr_plus <- function(x, y){

  # check whether input vectors are valid or not
  if(is.null(x) || is.null(y)){
    stop("Supply both 'x' and 'y'")
  }
  if(!(is.numeric(x) || is.logical(x))) stop("'x' must be numeric") # the input data should be numeric
  stopifnot(is.atomic(x))
  if(!(is.numeric(y) || is.logical(y))) stop("'y' must be numeric") # the input data should be numeric
  stopifnot(is.atomic(y))
  if(length(x) == 0L || length(y) == 0L){ # return ERROR if the inputs are empty
    stop("both 'x' and 'y' must be non-empty")
  }
  else if (length(x) == 1L || length(y) == 1L){ # return NA if The length of input equal to 1
    return (NA)
  }
  if (length(x) != length(y)){
    stop("incompatible dimensions")
  }

  # transform x and y which are coercible to one
  x <- if (is.vector(x) || is.factor(x)) x else as.double(x)
  y <- if (is.vector(y) || is.factor(y)) y else as.double(y)

  # treat infinite values as missing values
  x[is.infinite(x)] <- NA
  y[is.infinite(y)] <- NA

  # remove missing values
  nas <- attr(na.omit(cbind(x,y)), "na.action")
  if (length(nas)){
    x <- x[-nas]
    y <- y[-nas]
  }

  # calculate pearson correlation coefficient
  x_dif = x - mean(x)
  y_dif = y - mean(y)
  corr_value <- sum(x_dif * y_dif) / sqrt(sum(x_dif^2) *sum(y_dif^2))

  return (corr_value)
}
