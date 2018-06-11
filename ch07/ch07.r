## Chapter 07
## String and factor

# create and print string
c("You should use double quotes most of the time",
  'Single quotes are better for including " inside the string')

# paste function
paste(c("red", "yellow"), "lorry")
paste(c("red", "yellow"), "lorry", sep = "-")
paste0(c("red", "yellow"), "lorry")
paste(c("red", "yellow"), "lorry", collapse = ", ")
paste(c("red", "yellow"), "lorry", sep = "-", collapse = ", ")

# toString function
x<- (1:15)^2
toString(x)
toString(x, width = 40)

# cat function, (like Linux?)
cat(c("red", "yellow"), "lorry")

# noquote function
x <- c("I", "saw", "a", "saw", "that", "could", "out", "saw", "any", "other", "saw", "I", "ever", "saw")
y <- noquote(x)
x
y

# formating numbers
pow <- 1:3
powers_of_e <- exp(pow)

# formatC()
formatC(powers_of_e)
formatC(powers_of_e, digits = 3)
formatC(powers_of_e, digits = 3 , width = 10)
formatC(powers_of_e, digits = 3, format = "e")
formatC(powers_of_e, digits = 3, flag ="+")

# sprintf()
class(pow)
sprintf("%s %d = %f", "Euler's constant to the power", pow, powers_of_e)
sprintf("To three decimal places, e ^ %d = %.3f", pow, powers_of_e)
sprintf("In scientific notation, e ^ %d = %e", pow, powers_of_e)

# format() and prettyNum()
format(powers_of_e)
format(powers_of_e, digits = 3)
format(powers_of_e, digits = 3, trim = TRUE)
format(powers_of_e, digits = 3, scientific =  TRUE)
prettyNum(
  c(1e10, 1e-20),
  big.mark = ",",
  small.mark = " ",
  preserve.width = "individual",
  scientific = FALSE
)

# Special character
print("this\tis")
cat("this\tis")
cat("foo\tbar", fill = TRUE)
cat("foo\nbar")
cat("foo\0bar")
cat("foo\\bar")
cat("foo\"bar")
cat('foo\'bar')
cat("foo'bar")
cat('foo"bar')
cat("\a")
alarm()

# change case
toupper("I'm shouting")
tolower("I'm SHOuting")

# substring
woodchuck <- c(
  "How much wood would a woodchuck chuck",
  "If a woodchuck could chuck wood?",
  "He would chuck, he would, as much as he could",
  "And chuck as much wood as a woodchuck would",
  "If a woodchuck could chuck wood."
)
woodchuck
substring(woodchuck, 1, 6)
substring(woodchuck, 1:6, 6)
substring(woodchuck, 1:6, 10)
substr(woodchuck, 1:6, 10)

# split string
strsplit(woodchuck, " ", fixed = TRUE)
strsplit(woodchuck, ",? ")

# file paths
getwd()
setwd("C:/Users/Skuller/R/learningr")
file.path("c", "program files", "r")
R.home()
path.expand(".")
path.expand("..")
path.expand("~")
file_name <- "C:/Program Files/R/R-devel/bin/x64/RGui.exe"
basename(file_name)
dirname(file_name)


## Factors

# create factor
(heights <- data.frame(
  height_cm = c(153, 181, 150, 172, 165, 149, 174, 169, 198, 163),
  gender = c(
    "female", "male", "female", "male", "male",
    "female", "female", "male", "male", "female"
  )
))
class(heights$height_cm)
class(heights$gender)
heights$gender
heights$gender[1] <-"Female"
heights$gender
nlevels(heights$gender)

# using factor()
gender_char <- c(
  "female", "male", "female", "male", "male",
  "female", "female", "male", "male", "female"
)
(gender_fac <- factor(gender_char))

# change factor levels
# reverse the order of level, was "female", "male", is "male", "female"
factor(gender_char, levels = c("male", "female"))
# notice that, previous one used vector to create factor,  
# this one changed created factor
factor(gender_fac, levels = c("male", "female"))
levels(gender_fac) <- c("male", "female")
gender_fac
relevel(gender_fac, "male")

# drop factor levels
getting_to_work <- data.frame(
  mode = c(
    "bike", "car", "bus", "car", "walk",
    "bike", "car", "bike", "car", "car"
  ),
  time_mins = c(25, 13, NA, 22, 65, 28, 15, 24, NA, 14)
)
getting_to_work
(getting_to_work <- subset(getting_to_work, !is.na(time_mins)))
subset(getting_to_work, is.na(time_mins))

# unique function
unique(getting_to_work$mode)

# droplevels()
getting_to_work$mode <- droplevels(getting_to_work$mode)
getting_to_work
getting_to_work <- droplevels(getting_to_work)
levels(getting_to_work$mode)

# ordered factors
happy_choices <- c("depressed", "grumpy", "so-so", "cheery", "ecstatic")
happy_values <- sample(happy_choices, 10000, replace =  TRUE)
happy_choices
happy_values
happy_fac <- factor(happy_values, happy_choices)
head(happy_fac)

happy_ord <- ordered(happy_values, happy_choices)
head(happy_ord)

is.factor(happy_ord)
is.ordered(happy_ord)
is.ordered(happy_fac)

# Converting variale, between continous and categorical
ages <- 16 + 50 * rbeta(10000, 2, 3)
ages
grouped_ages <- cut(ages, seq.int(16, 66, 10))
grouped_ages
head(grouped_ages)
table(grouped_ages)
# test cut()
cut(c(11, 22, 23,34,55,62), seq.int(10,70, 10))
class(cut(c(11, 22, 23,34,55,62), seq.int(10,70, 10)))
class(ages)
class(grouped_ages)
# make a histogram 
hist(ages)

# processing dirty data
dirty <- data.frame(x = c("1.23","4..56", "7.89"))
dirty
as.numeric(dirty$x)

as.character(dirty$x)
as.numeric(as.character(dirty$x))

as.numeric(levels(dirty$x))
as.numeric(levels(dirty$x))[as.integer(dirty$x)]

# generat factor levels
gl(3,2)
gl(3,2, labels = c("placebo", "drug A", "drug B"))
gl(3, 1, 6, labels = c("placebo", "drug A", "drug B"))

# combine factors
treatment <- gl(3, 2, labels = c("placebo", "drug A", "drug B"))
gender <- gl(2, 1, 6, labels = c("female", "male"))
interaction(treatment, gender)

## Quiz
# Q7-1
format()
formatC()
sprintf()
prettyNum()

# Q7-2
alarm()
print("\a")

# Q7-3
# factor and ordered factors

# Q7-4
# get NA

# Q7-5
cut()

## Exercises
# E7-1
sprintf("%.15f", pi)
formatC(pi, digits = 16)

# E7-2
x <- c(
  "Swan swam over the pond, Swim swan swim!",
  "Swan swam back again - Well swum swan!"
)
strsplit(x, ",? -? ?")

# E7-3
three_d6 <- function(n)
{
  random_numbers <- matrix(
    sample(6, 3 * n, replace = TRUE),
    nrow = 3
  )
  colSums(random_numbers)
}
rt <- c(three_d6(1000))
rt
unique(rt)
table(rt)
t <-cut(rt, c(2,3,5,8,12,15,17,18))
t <-cut(rt, c(2,3,5,8,12,15,17,18), labels = -3:3)
table(t)      
