# ch02

# vector
1:5
6:10
1:5 + 6:10
1:5 + 6:11 # this raises a warning, since different size
c(1,2,3,4,5)
c(6,7,8,9,10)
c(1,2,3,4,5) + c(6,7,8,9,10)

# arithmetic operation using vector
sum(1:5)
median(1:5)
sum(1,2,3,4,5)
median(1,2,3,4,5)

c(2,3,5,7,11,13)-2
-2:2 * -2:2
identical(2^3, 2**3)

1:10 / 3
1:10 %/% 3    # integer division
1:10 %% 3     # reminder division

cos(c(0, pi/4, pi/2, pi))
exp(pi * 1i) +1
factorial(7)
factorial(1)
71**2
choose(5, 0:5)

# boolean operator
5 == 10
5 !=10
c(3, 4-1, 1+1+1) == 3
1:3 != 3:1
exp(1:5) <100
exp(1)
(1:5)^2 >=16

# compare no integer need to us all.equal(), when no same, all.equal() return
# difference, isTRUE() force to return boolean
sqrt(2)^2==2
sqrt(2)^2 - 2
all.equal(sqrt(2)^2, 2)
all.equal(sqrt(2)^2, 3)
isTRUE(all.equal(sqrt(2)^2, 3))
0^0


# string compare using ==
# string comparison is based on lexicographic order

c(  "Can", "you", "can", "a", "can", "as",  "a", "canner", 
    "can", "can", "a", "can?") == "can"
c("A", "B", "C", "D") < "C"
c("a", "b", "c", "d") < "C"

# assign
x <- 1:5
y = 6:10
x + 2*y -3

# global assignment <<-
x <<- exp(exp(1))
assign("my_local_variable", 9 ^ 3 + 10 ^ 3)

# wrap assignment within () will print it
z <- rnorm(5); z
(zz <- rnorm(5));zz

# special numbers
c(Inf + 1, Inf-1, Inf - Inf)
Inf/1
1/Inf
sqrt(Inf)
sin(Inf)

# notice the difference between NaN and NA
c(NA+1, NA*5, NA + Inf)
c(NA + NA, NaN + NaN, NaN + NA, NA + NaN)

# functions to check special numbers
x <- c(1, Inf, -Inf, NaN, NA)
is.infinite(x)
is.nan(x)
is.na(x)

# note this one below, x takes a vector of boolean values
x <- 1:10 >=5; x
!x
y <- 1:10%%2 == 0; y
x & y
!x & y
x | y

# TRUTH TABLE
# truth table example
x <- c(TRUE, FALSE, NA)
xy <- expand.grid(x=x, y=x)
within(
  xy,
  {
    and <- x&y
    or <- x|y
    not.x <- !x
    not.y <- !y
  }
)

# functions any and all
none_true <- c(FALSE, FALSE, FALSE)
some_true <- c(FALSE, TRUE, FALSE)
all_true <- c(TRUE, TRUE, TRUE)
any(none_true)
any(some_true)
any(all_true)
all(none_true)
all(some_true)
all(all_true)

## Quiz
# Q2-1
# integer division is %/%

# Q2-2
# all.equal(x, pi)

# Q2-3
# x <- 1
# x = 1
# assign(x, 1)

# Q2-4
# Inf and - Inf are infinite
is.infinite(c(0, Inf, -Inf, NaN, NA))

# Q2-5
# 0, Inf, -Inf, NaN is considered as missing
is.na(c(0, Inf, -Inf, NaN, NA))


## Exercises
# Exercise 2-1
(x <- atan2(1, 1:1000))
x <- c(1:1000)
y <- atan2(1, x)
z <- 1/tan(y); z

# Exercise 2-2 x, z from E2-1
x == z
identical(x, z)
all.equal(x,z)
all.equal(x,z, tolerance = 0)

# Exercise 2-3
true_and_missing <- c(TRUE, NA)
false_and_missing <- c(FALSE, NA)
mixed <- c(TRUE, FALSE, NA)
any(true_and_missing)
any(false_and_missing)
any(mixed)
all(true_and_missing)
all(false_and_missing)
all(mixed)
