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
tolower("I'm shouting")

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
