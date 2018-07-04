## Chapter 16
# Programming

# 1, Message, warning and error
# message function
f <- function(x){ message("'x' contains ", toString(x))
  x
}
f(letters[1:5])

# message() can be turned off
suppressMessages(f(letters[1:5]))

# warning function
g <- function(x){  if(any(x < 0))
  { warning("'x' contains negative values: ", toString(x[x < 0])) }
  x}
g(c(3, -7, 2, -9))

# warning() can be suppressed
suppressWarnings(g(c(3, -7, 2, -9)))

# global option "warn", 
# <0 : suppress warning text, 
# =0 or 1: showing warning text
# =>2: turn warning to error
getOption("warn")
options(warn = -1)
g(c(3, -7, 2, -9))
options(warn = 0)
options(warn = 1)
options(warn = 2)

getOption("warn")

# review the warning history
last.warning
warnings()

# Error
# stop()
h <- function(x, na.rm = FALSE){
  if(!na.rm && any(is.na(x)))  {
    stop("'x' has missing values.")
  }
  x
}
h(c(1, NA))

# stopifnot()
h <- function(x, na.rm = FALSE){
  if(!na.rm)  { stopifnot(!any(is.na(x)))
  }
  x
}
h(c(1, NA))

# use assertive pkg
install.packages("assertive")
library(assertive)
h <- function(x, na.rm = FALSE)
{
  if(!na.rm)
  {
    assert_all_are_not_na(x)
  }
  x
}
h(c(1, NA))

# 2, Error handling
# failed example
to_convert <- list(
  first = sapply(letters[1:5], charToRaw),
  second = polyroot(c(1, 0, 0, 0, 1)),
  third = list(x = 1:2, y = 3:5)
)

lapply(to_convert, as.data.frame)

# wrap with try function,  it will throw an error
result <- try(lapply(to_convert, as.data.frame))

# tryCatch()
tryCatch(
  lapply(to_convert, as.data.frame),
  error = function(e)
  {
    message("An error was thrown: ", e$message)
    data.frame()
  }
)

# revised example, third element is NULL now
lapply(
  to_convert,
  function(x)
  {
    tryCatch(
      as.data.frame(x),
      error = function(e) NULL
    )
  }
)

# tryapply in plyr pkg, very friendly and easy to use
library(plyr)
tryapply(to_convert, as.data.frame)

# 3, Debugging
# traceback(), browser() and recover()
outer_fn <- function(x) inner_fn(x)
inner_fn <- function(x) {
  #browser()
  recover()
  exp(x)}
outer_fn(list(1))
traceback()

# debug()
library(learningr)
buggy <- data(buggy_count, package = "learningr")
debug(buggy_count)
x <- factor(sample(c("male","female"), 20, replace =TRUE))
buggy_count(x)
x
class(x)

# 4, Testing
# e.g. hypotenuse function
hypotenuse <- function(x, y){
  sqrt(x ^ 2 + y ^ 2)}

# RUnit
install.packages("RUnit")
library(RUnit)
test.hypotenuse.3_4.returns_5 <- function(x){
 expected <- 5
 actual <- hypotenuse(3,4)
 checkEqualsNumeric(expected, actual)
}
test.hypotenuse.3_4.returns_5()

# test smallset and largest numbers
.Machine$double.xmin
.Machine$double.xmax
test.hypotenuse.very_small_inputs.returns_small_positive <- function()
{
  expected <- sqrt(2) * 1e-300
  actual <- hypotenuse(1e-300, 1e-300)
  checkEqualsNumeric(expected, actual, tolerance = 1e-305)
}
test.hypotenuse.very_small_inputs.returns_small_positive()

test.hypotenuse.very_large_inputs.returns_large_finite <- function()
{
  expected <- sqrt(2) * 1e300
  actual <- hypotenuse(1e300, 1e300)
  checkEqualsNumeric(expected, actual)
}
test.hypotenuse.very_large_inputs.returns_large_finite()

# defineTestSuite(), then runTestSuite()
test_dir <- system.file("tests", package = "learningr")
suite <- defineTestSuite("hypotenuse suite", test_dir)
runTestSuite(suite)



