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

# testthat pkg
install.packages("testthat")
library(testthat)
# expect_*
expect_equal(hypotenuse(3, 4), 5)
expect_error(hypotenuse())
expect_equal(hypotenuse(1e-300, 1e-300), sqrt(2) * 1e-300, tol = 1e-305)
expect_equal(hypotenuse(1e300, 1e300), sqrt(2) * 1e300)

# test_file finction
filename <- system.file(
  "tests",
  "testthat_hypotenuse_tests.R",
  package = "learningr"
)
test_file(filename)

# test_that() and test_package
test_that()

# warning be tested via expect_warning
expect_warning(log(0))

# Magic
# turn the string into code
# e.g.
atan(c(-Inf, -1, 0, 1, Inf))
# quote function and eval function
# R do eval(quote())
(quoted_r_code <- quote(atan(c(-Inf, -1, 0, 1, Inf))))
class(quoted_r_code)
eval(quoted_r_code)
# check the call object
as.list(quoted_r_code)

# In R, everything is a function
vapply(  list("+", "if", "for", "<-", "[","[["),
  is.function, logical(1))
is.function('for')

# parse function
parse(filename)
parsed_r_code <- parse(text = "atan(c(-Inf, -1, 0, 1, Inf))")
class(parsed_r_code)
eval(parsed_r_code)

# turn code into string
# e.g. 
random_numbers <- rt(1000, 2)
hist(random_numbers)
# substitue function and deparse function
divider <- function(numerator, denominator){
  if(denominator == 0)  {
    denominator_name <- deparse(substitute(denominator))
    warning("The denominator, ", sQuote(denominator_name), ", is zero.")
  }
  numerator / denominator
}
top <- 3
bottom <- 0
divider(top, bottom)

# 5, OOP
# s3 class
print
today <- Sys.Date()
print(today)
print.Date
head(methods(print))


# Reference Class
my_class_generator <- setRefClass(
  "MyClass",
  fields = list(
    #data variables are defined here
  ),
  methods = list(
    #functions to operate on that data go here
    initialize = function(...)
    {
      #initialize is a special function called
      #when an object is created.
    }
  )
)

point_generator <- setRefClass(
  "point",
  fields = list(
    x = "numeric",
    y = "numeric"
  ),
  methods = list(
    initialize = function(x = NA_real_, y = NA_real_)
    {
      "Assign x and y upon object creation."
      x <<- x
      y <<- y
    },
    distanceFromOrigin = function()
    {
      "Euclidean distance from the origin"
      sqrt(x ^ 2 + y ^ 2)
    },
    add = function(point)
    {
      "Add another point to this point"
      x <<- x + point$x
      y <<- y + point$y
      .self
    }
  )
)

(a_point <- point_generator$new(5, 3))

# construct a new object
point_generator(1, 10)
point_generator$help("initialize")

create_point <- function(x, y){
  point_generator$new(x, y)
}
a_point <- create_point(3,4)
a_point$distanceFromOrigin()
a_point$add(a_point)
# list the fields and methods in class
point_generator$fields()
point_generator$methods()

# inheritance
three_d_point_generator <- setRefClass(
  "three_d_point",
  fields = list(
    z = "numeric"
  ),
  contains = "point", #this line lets us inherit
  methods = list(
    initialize = function(x, y, z)
    {
      "Assign x and y upon object creation."
      x <<- x
      y <<- y
      z <<- z
    },
    distanceFromOrigin = function()
    {
      "Euclidean distance from the origin"
      sqrt(x ^ 2 + y ^ 2 + z ^ 2)
    }
  )
)
a_three_d_point <- three_d_point_generator$new(3, 4, 5)
a_three_d_point$distanceFromOrigin()

## Quiz
# Q16-1
# warnings()

# Q16-2
# return an object of try-error

# Q16-3
# checkException in RUnit = expect_* in testthat

# Q16-4
# quote and eval functions

# Q16-5
# overload methods