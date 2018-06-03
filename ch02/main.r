# ch02

# vector
1:5
6:10
1:5 + 6:10
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
1:10/3
1:10%/%3    # integer division
1:10%%3     # reminder division

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
