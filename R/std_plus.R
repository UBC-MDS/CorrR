#' Bind two factors
#'
#' Create a new factor from two existing factors, where the new factor's levels
#' are the union of the levels of the input factors.
#'
#' @param a factor
#' @param b factor
#'
#' @return factor
#' @export
#' @examples
#' std_plus(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
std_plus <- function(a, b) {
  factor(c(as.character(a), as.character(b)))
}
