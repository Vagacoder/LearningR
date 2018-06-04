## Chapter 03

# class (= type in textbook)
class(c(TRUE, FALSE))
class(c(1,4,7))
?class

# different types of number
class(sqrt(1:10))
class(3+1i)
class(1)      # this is "numeric"
class(1L)     # with "L", this is integer
class(1:5)    # all values are whole number, it is integer
class(0.5:4.5)    # not all whole number, it is numeric
0.5:4.5

# other types
class(c("she", "sells", "this", "food", 1, TRUE))
(gender <- factor(c("male", "female", "female", "male", "female")))   

# levels attributes
levels(gender)
nlevels(gender)

as.integer(gender)
as.factor(gender)
object.size(gender)

# 32 bit and 64 bit system take different memory size 
gender_char <- sample(c("female", "male"), 10000, replace = TRUE)
gender_fac <- as.factor(gender_char)
object.size(gender_char)
object.size(gender_fac)
gender_char
gender_fac

# switch the factor to string (chpater 7)
as.character(gender)

# raw type, each raw is one byte (2 hexdecimal numbers)
as.raw(1:17)
as.raw(c(pi, 1 + 1i, -1, 256))
as.raw(c(pi))
(sushi <- charToRaw("Fish!"))
class(sushi)

# check the class
if (!is(sushi, "raw")){
  print("sushi is not raw!")
} else {
  print("sushi is RAW!")
}

# check class using is.*, this is more convenient than is function
is.character(1)
is.logical(FALSE)
is.list(list(a=1, b= 2))

ls(pattern = "^is", baseenv())

# watch out the integer and float number class checking, 
# is.numeric is all true for integer and float
is.numeric(1)
is.numeric(1L)
is.integer(1)
is.integer(1L)
is.double(1)
is.double(1L)

# cast
x <- "123.456"
x
as (x, "numeric")
y <- "87.12"
y
as.numeric(y)
class(x) <- "character"
x

# auto printing
numbers <- c(1,2,3,4,5,6)
for (i in numbers) i
for (i in numbers) print(i)

# summary function
num <- runif(30)
num
summary(num)
fac <- factor(sample(letters[1:5], 30, replace = TRUE))
fac
summary(fac)

bool <- sample(c(TRUE, FALSE, NA), 30, replace = TRUE)
bool
summary(bool)

# make a data frame and get summary 
dfr <- data.frame(num, fac, bool)
dfr
head(dfr)
summary(dfr)

# structure 
str(num)
str(dfr)

# unclass function can override default print function
unclass(fac)

# attribute function
attributes(fac)

# View edit and fixfunction
View(fac)
new_dfr <- edit(dfr)
new_dfr
fix(new_dfr)
new_dfr

# list variables
ls()
ls(all.names = TRUE)
ls(pattern = "bo")
ls.str()
browseEnv()

# remove variable
new_dfr
rm(new_dfr)

# Exercise 3-1

# put everything into a vector does not work
a <- c(Inf, NA, NaN)
class(a)
for (i in a ) print(class(i))

# Inf NaN are number, NA is boolean, "" is string
class(Inf)
typeof(Inf)
mode(Inf)
storage.mode(Inf)
class(NA)
typeof(NA)
mode(NA)
storage.mode(NA)
class(NaN)
typeof(NaN)
mode(NaN)
storage.mode(NaN)
class("")
typeof("")
mode("")
storage.mode("")


# E3-2
animals = c("dog", "cat", "hamster", "goldfishe")
chosen <- sample(animals, 1000, replace = TRUE)
head(chosen)
summary(chosen)
nlevels(factor(chosen))


# E3-3
celery <- 1
cabege <- 2
nappa <- 3
tomato <- 4
cucumber <- 5

ls(pattern = "a")
