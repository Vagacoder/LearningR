## Chapter 04

# : function and c function
8.2 : 13.9
c(1, 1:5, 8:10, 15)

# vector function declare and initialize vector using default value
vector("numeric", 5)
vector("complex", 5)
vector("logical", 5)
vector("character", 5)
vector("list", 5)

# for convenience, initialize vector like array in java
numeric(5)
complex(5)
logical(5)
character(5)
list(5)    # this gives difference result

# seq function

seq.int(3, 12)
seq(3, 12)
seq.int(3,12,2)
seq(3,12,2)
seq(0.1, 0.01, -0.01)

# seq.int() == seq()
(a <- seq.int(1,3))
(b <- seq(1,3))
a == b

# seq.len
n <- 0
1:n
seq_len(n) # this is extremly useful for input could be zero

# seq_along
pp <- c("Peter", "Piper", "picked", "a", "peck", "of", "pickled", "peppers")
for(i in seq_along(pp)) print(pp[i])
for(i in seq(pp)) print(pp[i])

# length
length(1:5)
length(c(TRUE, FALSE, NA))

# notice: length and nchar on string vector give different result
length(c("sheena", "leads", "shileds", "need"))
nchar(c("sheena", "leads", "shileds", "need"))
nchar("give")

# length can set a new length to a vector (may truncat some elements)
poincare <- c(1, 0, 0, 0, 2, 0, 2, 0)
length(poincare)
length(poincare) <- 3
poincare
length(poincare) <- 8
poincare

# Name (for each element in vector)
y <- c(apple = 1, banana =2 , "kiwi fruit" = 3, 4 )
y["kiwi fruit"]
names(y)
# add name after creation using name function
x <- 1:4
names(x)
names(x) <- c("apple", "banana", "kiwi fruit", "")
x
names(x)

# names can retrive names
names(x)
names(1:4)

# indexing
x <- (1:5)^2
x
x[c(1,3,5)]
x[c(-2, -4)]
x[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
x[1]
x[(123)]
names(x) <- c("one", "four", "nine", "sixteen", "twenty five")
x[c("one", "nine", "twenty five")]

# this mixing positive and negative is not allowed
x[c(1, -1)]
x[c(1,NA,5)]
x[c(TRUE, FALSE, NA, FALSE, TRUE)]
# this mixing negative and missing value is not allowed
x[c(-2, NA)]
x[1.9]
x[2.4]
x[-1.9]
x[]
which(x > 10)
which.min(x)
min(x)
which.max(x)

# vectors addition
1:5+1
1+ 1:5
1:5 + 1:15
1:5 + 1:14
# please note the different this one 
c(1:5, 1:15)

# rep function
rep(1:5, 3)
rep(1:5, each = 3)
rep(1:5, times = 1:5)
rep(1:5, length.out = 7)
rep.int(1:5, 3)
rep_len(1:5, 13)

## Matrices and Arrays
# array function
three_d_array <- array(1:25, 
                       dim = c(4,3,2), 
dimnames = list(c("one", "twO", "three", "four"), 
                c("ein", "zwei", "drei"), 
                c("un", "deux")
                )
                )

three_d_array                                                        
class(three_d_array)

# matrix function
a_matrix <- matrix(1:12,
                   nrow = 4,
                   dimnames = list(
                     c("one", "two", "three", "four"),
                     c("ein", "zwei", "drei")
                   ))
a_matrix
class(a_matrix)

(two_d_array <- array(
  1:12,
  dim = c(4, 3),
  dimnames = list(
    c("one", "two", "three", "four"),
    c("ein", "zwei", "drei")
  )
))
identical(two_d_array, a_matrix)
class(two_d_array)

# dim function
dim(a_matrix)
dim(three_d_array)
dim(two_d_array)
nrow(a_matrix)
ncol(a_matrix)

nrow(c(1:5))
NROW(c(1:5))
NCOL(c(1:5))

length(three_d_array)

# reshape a matrix
dim(a_matrix) <- c(6,2)
a_matrix
dim(three_d_array) <- c(2,4,3)
three_d_array

# names of row, col and dimension
a_matrix <- matrix(1:12,
                   nrow = 4,
                   dimnames = list(
                     c("one", "two", "three", "four"),
                     c("ein", "zwei", "drei")
                   ))
rownames(a_matrix)
colnames(a_matrix)
dimnames(a_matrix)

three_d_array <- array(1:25, 
                       dim = c(4,3,2), 
                       dimnames = list(c("one", "twO", "three", "four"), 
                                       c("ein", "zwei", "drei"), 
                                       c("un", "deux")
                       )
)
rownames(three_d_array)
colnames(three_d_array)
dimnames(three_d_array)

# array indexing
a_matrix
a_matrix[10]
a_matrix[1, c("zwei", "drei")]
a_matrix[1,]
a_matrix[, c("zwei", "drei")]

# combine matrices
(another_matrix <- matrix(
  seq.int(2, 24, 2),
  nrow = 4,
  dimnames = list(
    c("five", "six", "seven", "eight"),
    c("vier", "funf", "sechs")
  )
))

c(a_matrix, another_matrix)

cbind(a_matrix, another_matrix)
rbind(a_matrix, another_matrix)

# Array arithmetic
a_matrix + another_matrix
a_matrix * another_matrix

t(a_matrix)

# inner multiplication
a_matrix %*% t(a_matrix)
#outer multiplication
1:3 %o% 4:6
outer(1:3, 4:6)

# invert matrix
(m <- matrix(c(1, 0, 1, 5, -3, 1, 2, 4, 7), nrow = 3))
m ^ -1
(inverse_of_m <- solve(m))
m %*% inverse_of_m

# ===================
## Quiz
#Q4-1
c <- c(0, 0.25, 0.75, 1)
c
seq.int(0,1, 0.25)

# Q4-2
names(c) <- c("zero", "point 25", "point 75", "one")
c
d <- c("one" = "A", "two" = "B", "three" = "C", "four" = "D")
d
e <- c(1,2,3,4)
names(e)

#Q4-3
d[2]
d[c(1,2,4)]

d[-3]
d[c(-3)]

d[c(TRUE, TRUE, FALSE, TRUE)]
d[c("one", "two","four")]

#Q4-4
new_array <- array(1:60,
                   dim=c(3, 4,5))
new_array
dim(new_array)
length(new_array)

#Q4-5
#%*%

# ==================
## Excercise
# Exercise 4-1

(number <- seq.int(1:20))
(tri20 <- number * (number+1)/2)
letters
seq_along(number)
#names(tri20) <- letters[seq_along(number)]

names(tri20) <- letters[c(1:20)]
tri20
tri20[c("a", "e", "i", "o")]

# Exercise 4-2
(a <- c(seq.int(10,0,-1),seq.int(1, 10)))
rec42 <- diag(a)
rec42
diag(abs(seq.int(-10,11)))

# Exercise 4-3
a <- rep(1, times= 20)
a
b <- diag(a, 20, 21)
b
#newrow <- rep(0, times =21)
#rbind(newrow, b)
rec431 <- rbind(0, b)
rec431

c <- diag(a, 21, 20)
c
rec432 <- cbind(0,c)
rec432

newrec <- rec42 + rec431 + rec432  
newrec
eigen(newrec)$values
