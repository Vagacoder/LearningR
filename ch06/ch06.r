## Chapter 06

# new environment
an_environment <- new.env()

# assign variable to environment
an_environment[["pythag"]] <- c(12, 15, 20, 21)
an_environment$root <- polyroot(c(6, -5, 1))
assign(
  "moonday",
  weekdays(as.Date("1969/07/20")),
  an_environment
)
View(an_environment)

# retrieve variable form environment
an_environment[["pythag"]]
an_environment$root
moonday <- get("moonday", an_environment)

# list environment content
ls(an_environment)
ls(envir = an_environment)
ls.str(envir = an_environment)

# exists functin
exists("pythag", an_environment)
exists("python", an_environment)

#Convert to list
(a_list <- as.list(an_environment))

# to environment
new_env <- as.environment(a_list)
new_env1 <- list2env(a_list)

# nested environment
nested_environment <- new.env(parent = an_environment)
exists("pythag", nested_environment)
exists("pythag", nested_environment, inherits = FALSE)
nested_environment
View(nested_environment)

# all new variables are stored in globalenv()
non_stormers <<- c(3, 7, 8, 13, 17, 18, 21)
get("non_stormers", envir = globalenv())
ls(envir = globalenv())

# all R build-in functions are stored in baseenv()
head(ls(envir = baseenv()), 20)
ls(envir = baseenv())

## Functions
# check the code of function
rt(10, 5)
rt

# create our own function
hypotenuse <- function(x, y)
{
  sqrt(x^2 + y ^2)
}
hypotenuse(3, 4)
hypotenuse()
formals(hypotenuse)
args(hypotenuse)
formalArgs(hypotenuse)

# provide default values for arguments
hypotenuse <- function(x = 5, y = 12)
{
  sqrt(x^2 + y ^2)
}
hypotenuse()
formals(hypotenuse)
args(hypotenuse)
formalArgs(hypotenuse)

# get the code body of function
(body_of_hypotenuse <- body(hypotenuse))
deparse(body_of_hypotenuse)

# pass functions to arguments
normalize <- function(x, m = mean(x), s = sd(x))
{
  (x - m) / s
}
normalize(c(1, 3, 6, 10, 15))
normalized <- normalize(c(1, 3, 6, 10, 15))
mean(normalized)
sd(normalized)
normalize(c(1, 3, 6, 10, NA))

# improve normalize function using na.rm 
normalize <- function(x, m = mean(x, na.rm = na.rm),
                      s = sd(x, na.rm = na.rm), na.rm = FALSE)
{
  (x - m) / s
}
normalize(c(1, 3, 6, 10, NA))
normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)

normalize <- function(x, m = mean(x, ...), s = sd(x, ...), ...)
{
  (x - m) / s
}
normalize(c(1, 3, 6, 10, NA))
normalize(c(1, 3, 6, 10, NA), na.rm = TRUE)

# pass functions to and from other functions
do.call(hypotenuse, list(x = 3, y = 4))
# most common use:
# combine the rbind() with do.call()
dfr1 <- data.frame(x = 1:5, y = rt(5, 1))
dfr2 <- data.frame(x = 6:10, y = rf(5, 1, 1))
dfr3 <- data.frame(x = 11:15, y = rbeta(5, 1, 1))
dfr1
dfr2
dfr3
do.call(rbind, list(dfr1, dfr2, dfr3)) #same as rbind(dfr1, dfr2, dfr3)

menage <- c(1, 0, 0, 1, 2, 13, 80)
mean(menage)
mean(c(1, 0, 0, 1, 2, 13, 80))

# do.call anonymously
x_plus_y <- function(x, y) x + y
do.call(x_plus_y, list(1:5, 5:1))
do.call(function(x, y) x + y, list(1:5, 5:1))

# ecdf example 
(emp_cum_dist_fn <- ecdf(rnorm(50)))
is.function(emp_cum_dist_fn)
plot(emp_cum_dist_fn)            

## Variable scope
# g is subclass of f
f <- function(x)
{
  y <- 1
  g <- function(x)
  {
    (x + y) / 2 #y is used, but is not a formal argument of g
  }
  g(x)
}
f(sqrt(4))

# g is not subclass of f
f <- function(x)
{
  y <- 1
  g(x)
}
g <- function(x)
{
  (x + y) / 2
}
f(sqrt(5))

## Quiz
# Q6-1
# global environment = user workspace

# Q6-2
# as.environment() and list2env, as.list() for opposite ops

# Q6-3
# type the name of function

# Q6-4
# formals, args, formalArgs

# Q6-5
# call function with its arguments in a list form 

## Exercises
# E6-1

multiples_of_pi <- new.env()
multiples_of_pi[["two_pi"]] <- 2*pi
multiples_of_pi$three_pi <- 3*pi
assign("four_pi", 4*pi, multiples_of_pi)
View(multiples_of_pi)
ls(multiples_of_pi)
ls.str(multiples_of_pi)

# E6-2
checknumber <- function(x)
{
  (x %% 2) ==0
}
checknumber(c(-5:5, Inf, -Inf, NA, NaN))

# E6-3
defunction <- function(x)
{
  c(formalArgs(x), body(x))
}
defunction(rt)
