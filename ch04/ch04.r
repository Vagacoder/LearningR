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
c(apple = 1, banana =2 , "kiwi fruit" = 3,4 )

# add name after creation using name function
x <- 1:4
names(x) <- c("apple", "banana", "kiwi fruit", "")
x

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