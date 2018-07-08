#' Sum of Square
#' 
#' @param x input number
#' @return result the sum of square from 1 to x
#' @note none
#' @author QH
#' @references none
#' @seealso none
#' @examples none
#' @keywords misc
#' @export

sum_of_squares <-
function(x){
  result <- x *(x+1)*(2*x +1)/6
  result
}
