## Chapter 17
# Making package

# need devtools and roxygen2
install.packages(c("devtools","roxygen2"))

# 1, first pkg
# set a function and a data frame
hypotenuse <- function(x, y){
  sqrt(x ^ 2 + y ^ 2)
}
pythagorean_triples <- data.frame(
  x = c(3, 5, 8, 7, 9, 11, 12, 13, 15, 16, 17, 19),
  y = c(4, 12, 15, 24, 40, 60, 35, 84, 112, 63, 144, 180),
  z = c(5, 13, 17, 25, 41, 61, 37, 85, 113, 65, 145, 181)
)

# package.skeleton() 
package.skeleton(
  "pythagorus",
  c("hypotenuse", "pythagorean_triples")
)

# 2, Documenting package
# roxygen2 pkg
# each line starts with "#`"
# each keyword starts with "@"

# to see the list of possible values, use R.oo pkg
install.packages("R.oo")
library(R.methodsS3)
library(R.oo)
Rdoc$getKeywords()

# 3, checking and building packages
# check function in devtools pkg
library(devtools)
check("pythagorus")

# 4, maintaning the package
# .NotYetUsed function
# .NotYetImplemented functin
# .Deprecated function
# .Defunct function

## Quiz
# Q17-1
# DESCRIPTION NAMESPACE

# Q17-2
# R man

# Q17-3
# show how would you like to cite this package

# Q17-4
# roxygenize()

# Q17-5
# .Deprecated() then .Defunct()

## Exercises
# E17-1
sum_of_squares <- function(x){
  result <- x *(x+1)*(2*x +1)/6
  result
}
sum_of_squares(2)
square_data <- data.frame(c(1:10), sum_of_squares(1:10))
package.skeleton("sum_square", c("sum_of_squares", "square_data" ))

# E17-2
# E17-3
check("sum_square")
build("sum_square")
