## Chapter 05 List

# Create list
a_list <- list(c(1,1,2,5,14, 42),
               month.abb,
               matrix(c(3,-8, 1,-3),
                      nrow =2),
               asin)
a_list

# add names to list
names(a_list) <- c("catalan", "months", "involutary", "arcsin")
a_list

# list inside list
(main_list <- list(
  middle_list = list(
    element_in_middle_list = diag(3),
    inner_list = list(
      element_in_inner_list = pi ^ 1:4,
      another_element_in_inner_list = "a"
    )
  ),
  element_in_main_list = log10(1:10)
))

# atomic and recursive variabnle
is.atomic(list())
is.recursive(list())
is.atomic(numeric())
is.recursive(numeric())

# length of list, number of top level elements
length(a_list)
length(main_list)
# but list has NO dimension
dim(a_list)
# nrow does not work, NROW works
nrow(a_list)
NROW(a_list)

# List cannot do arithmetic work, but appropriate elements can do
l1 <- list(1:5)
l2 <- list(6:10)
l1[1] + l2[1]
l1[[1]] + l2[[1]]
print(l1[1])
print(l1)

# indexing list
l <- list(
  first = 1,
  second = 2,
  third = list(
    alpha = 3.1,
    beta = 3.2
  )
)
# indexing like vector, positive, negative, name, boolean
l
l[1:2]
l[-3]
l[c(TRUE, TRUE, FALSE)]
l[c("first","second")]
# access content of element, using [[]]
l[[1]]
l[["first"]]

# is.list function
l1
is.list(l1)
is.list(l1[[1]])
typeof(l1[1])     # type of list
typeof(l1[[1]])   # type of integer

l$first
l$f

# nested list
l[["third"]]["beta"]
l[["third"]][["beta"]]
l[[c("third", "beta")]]

# NULL, if the index is out of boundary
l[c(4,2,5)]
l[["fourth"]]
l[[4]]
l[[3]]
l[[2]]
l[[1]]
l[[3]][[1]]
l[[3]][[2]]

# Convert vector and list
busy_beaver <- c(1, 6, 21, 107)
as.list(busy_beaver)
as.numeric(list(1,6,21,107))

(prime_factors <- list(
  two = 2,
  three = 3,
  four = c(2, 2),
  five = 5,
  six = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine = c(3, 3),
  ten = c(2, 5)
))
unlist(prime_factors)

# Combine lists
c(list(a=1, b=2), list(3))
c(list(a=1, b=2), 3)

(matrix_list_hybrid <- cbind(
  list(a = 1, b = 2),
  list(c = 3, list(d = 4))
))
str(matrix_list_hybrid)

# NULL
(uk_bank_holidays_2013 <- list(
  Jan = "New Year's Day",
  Feb = NULL,
  Mar = "Good Friday",
  Apr = "Easter Monday",
  May = c("Early May Bank Holiday", "Spring Bank Holiday"),
  Jun = NULL,
  Jul = NULL,
  Aug = "Summer Bank Holiday",
  Sep = NULL,
  Oct = NULL,
  Nov = NULL,
  Dec = c("Christmas Day", "Boxing Day")
))

# properties of NULL
length(NULL)
length(NA)
is.null(NULL)
is.null(NA)
is.na(NULL)

# REMOVE Jan and Feb
uk_bank_holidays_2013$Jan <- NULL
uk_bank_holidays_2013$Feb <- NULL
uk_bank_holidays_2013

# SET Aug to NULL
uk_bank_holidays_2013["Aug"] <- list(NULL)
uk_bank_holidays_2013

# Pairlist
(arguments_of_sd <- formals(sd))
pairlist()

# Data frame
(a_data_frame <- data.frame(
  x = letters[1:5],
  y = c(rnorm(4), 1),
  z = runif(5) > 0.5
))
class(a_data_frame)

# name of data frame rows
x = letters[1:5]
names(x) <- c("a", "b", "c", "d", "e")
y <- rnorm(5)
names(y) <- month.name[1:5]
data.frame(
  x = x,
  y = y,
  z = runif(5) > 0.5
)
data.frame(
  x = letters[1:5],
  y = y,
  z = runif(5) > 0.5,
  row.names = NULL
)
data.frame(
  x = letters[1:5],
  y = y,
  z = runif(5) > 0.5,
  row.names = c("Jackie", "Tito", "Jermaine", "Marlon", "Michael")
)

# different length of vectors in data frame
data.frame( #lengths 1, 2, and 4 are OK
  x = 1, #recycled 4 times
  y = 2:3, #recycled twice
  z = 4:7 #the longest input; no recycling
)
data.frame( #lengths 1, 2, and 3 cause an error
  x = 1, #lowest common multiple is 6, which is more than 3
  y = 2:3,
  z = 4:6
)

# Indexing data frame
a_data_frame
a_data_frame[2:3, -3]
a_data_frame[2:3, 1]
a_data_frame[c(FALSE, TRUE, TRUE, FALSE, FALSE), c("x", "y")]
class(a_data_frame[2:3, -3])
class(a_data_frame[2:3, 1])

# indexing element in data frame
a_data_frame$x[2:3]
a_data_frame[[1]][2:3]
a_data_frame[["x"]][2:3]

# subset of data frame
a_data_frame[a_data_frame$y > 0 | a_data_frame$z, "x"]
subset(a_data_frame, y > 0 | z, x)

# data frame manipulation
a_data_frame
t(a_data_frame)     # Notice: all elements are converted to same type
t(t(a_data_frame))

another_data_frame <- data.frame( #same cols as a_data_frame, different order
  z = rlnorm(5), #lognormally distributed numbers
  y = sample(5), #the numbers 1 to 5, in some order
  x = letters[3:7]
)

# use rbind and cbind on 2 data frames
rbind(a_data_frame, another_data_frame)
cbind(a_data_frame, another_data_frame)

# merge
merge(a_data_frame, another_data_frame, by = "x")
merge(a_data_frame, another_data_frame, by = "z")
merge(a_data_frame, another_data_frame, by = "x", all = TRUE)
merge(a_data_frame, another_data_frame, all = TRUE)

# colSums and colMeans
colSums(a_data_frame[, 2:3])
colMeans(a_data_frame[, 2:3])

# Quiz ==================
# Q5-1
NROW(list(alpha = 1, list(beta = 2, gamma = 3, delta = 4), eta = NULL))
# note, nrow does not work for list. Should use NROW

# Q5-2
# pairlist for arguments, call formals(), global enviroment variabe.options

# Q5-3
# 1, subset()
# 2, using indexing

# Q5-4
# 1, create using merge()
# 2, create using cbind()
#
# By passing check.names = FALSE to data.frame.
data.frame(
  x = letters[1:5],
  x = month.name[1:5],
  z = runif(5) > 0.5,
  check.names = FALSE
)
# Q5-5
# 1, merge()
# 2, cbind() rbind()

# Exercise ================================
# E5-1
# find square of 1 to 10 (square range 1 to 100)
number <- c(1:10)
sq <- number**2
# make a list
list(c(0,1,4,9), c(16), 25, 36, 49, NULL, 64, NULL, 81, NULL)

# a much better method from textbook
x <- 0:99
sqrt <- sqrt(x)
isSq <- sqrt == floor(sqrt)
sqNumber <- x[isSq]
sqNumber
groups <- cut(
  sqNumber,
  seq.int(min(x), max(x), 10),
  include.lowest = TRUE,
  right = FALSE
)
split(sqNumber, groups)
#

# E5-2
iris
typeof(iris)
sub_iris <- subset(iris, TRUE, c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width))
sub_iris <- iris[, 1:4]
sub_iris
colSums(sub_iris)
colSums(sub_iris)/NROW(sub_iris)

# E5-3
n1 <- nrow(beaver1)
n2 <- nrow(beaver2)
id <- rep(1, n1)
newB1 <- cbind(id, beaver1)
id <- rep(2, n2)
newB2 <- cbind(id, beaver2)
newB <- rbind(newB1, newB2)
# newAB <- newB["activ" == 1,1:5]
newAB <- subset(newB, activ == 1)
