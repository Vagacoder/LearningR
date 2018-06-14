## Chpater 08
# Flow controls and loops

# if and else
if(TRUE) message("It was true!")
if(FALSE) message("It wasN'T true!")
if(NA) message("Missing something")

if(runif(1) > 0.5) message("This message appears with a 50% chance.")

# it's better to include inside curly braces
x <- 3
if(x > 2)  
  {
  (y <- 2 * x)
#  print(y)
  (z <- 3 * y)
}

# else statement
if(FALSE){  message("This won't execute...")}else {  message("but this will.")}

# nested if else statements
(r <- round(rnorm(2), 1))
(x <- r[1] / r[2])

if(is.nan(x)){
  message("x is missing")
} else if(is.infinite(x)){
  message("x is infinite")
} else if(x > 0){
  message("x is positive")
} else if(x < 0){
  message("x is negative")
} else{
  message("x is zero")
}

# conditional assignment
x <- sqrt(-1 + 0i)
x
(reality <- if(Re(x) == 0) "real" else "imaginary")

# vectorized if 
if(c(TRUE, FALSE)) message("two choices")
ifelse(rbinom(10, 1, 0.5), "Head", "Tail")
i <- rbinom(10,1,0.5)
i
ifelse(i, "Here","There")

(yn <- rep.int(c(TRUE, FALSE), 6))
ifelse(yn, 1:3, -1:-12)

# NA results in NA
yn[c(3, 6, 9, 12)] <- NA
ifelse(yn, 1:3, -1:-12)

# switch
(greek <- switch(
  "gamma",
  alpha = 1,
  beta = sqrt(4),
  gamma =  {
    a <- sin(pi / 3)
    4 * a ^ 2  } )
  )

(greek <- switch(
  "delta",
  alpha = 1,
  beta = sqrt(4),
  gamma =  {
    a <- sin(pi / 3)
    4 * a ^ 2  }
))

(greek <- switch(
  "delta",
  alpha = 1,
  beta = sqrt(4),
  gamma =
  {
    a <- sin(pi / 3)
    4 * a ^ 2
  },
  4
))

# e.g of switch()
j <- "alpha"
switch(
  j,
  alpha = 1,
  beta = sqrt(4),
  gamma =
  {
    a <- sin(pi / 3)
    4 * a ^ 2
  },
  4
)

# another e.g. pf switch() w/o using names
switch(
  3,
  "first",
  "second",
  "third",
  "fourth"
)

# for large number, convert it to string 
switch(
  as.character(2147483647),
  "2147483647" = "a big number",
  "another number"
)

## Loops
# repeat loop (do while loop)
repeat {
  message("Happy Groundhog Day!")}

# use break
repeat{
  message("Happy Groundhog Day!")
  action <- sample(
    c(
      "Learn French",
      "Make an ice statue",
      "Rob a bank",
      "Win heart of Andie McDowell"
    ),
    1
  )
  message("action = ", action)
  if(action == "Win heart of Andie McDowell") break
}

# use next (skip current loop and go to next one)
repeat{
  message("Happy Groundhog Day!")
  action <- sample(
    c(
      "Learn French",
      "Make an ice statue",
      "Rob a bank",
      "Win heart of Andie McDowell"
    ),
    1
  )
  if(action == "Rob a bank")  {
    message("Quietly skipping to the next iteration")
    next
  }
  message("action = ", action)
  if(action == "Win heart of Andie McDowell") break
}

# while loop
action <- sample(
  c(
    "Learn French",
    "Make an ice statue",
    "Rob a bank",
    "Win heart of Andie McDowell"
  ),
  1
)
while(action != "Win heart of Andie McDowell"){
  message("Happy Groundhog Day!")
  action <- sample(
    c(
      "Learn French",
      "Make an ice statue",
      "Rob a bank",
      "Win heart of Andie McDowell"
    ),
    1
  )
  message("action = ", action)
}

# for loops
for(i in 1:5) {message("i = ", i)}
for(i in 1:5){
  j <- i ^ 2
  message("j = ", j)
}

for(month in month.name){
  message("The month of ", month)
}

for(yn in c(TRUE, FALSE, NA)){
  message("This statement is ", yn)
}

l <- list(
  pi,
  LETTERS[1:5],
  charToRaw("not as complicated as it looks"),
  list(
    TRUE
  )
)
for(i in l){
  print(i)
}

## Quiz
# Q8-1
# using NA in the conditin of if will results in error.

# Q8-2
# using NA in the condition of ifelse results in NA

# Q8-3
# String (character) and integer

# Q8-4
# escape, terminate R or includes break in code

# Q8-5
# next

## Exercises
# E8-1
two_d6 <- function(n){
  random_numbers <- matrix(
    sample(6, 2 * n, replace = TRUE),
    nrow = 2
  )
  colSums(random_numbers)
}

crap_score <- two_d6(1)
game_status <- c(FALSE, TRUE, NA)
point <- c(NA, NA, "Same as score")

if (crap_score %in% c(2,3,12)){
  game_status <- FALSE
  point <- NA
} else if (crap_score %in% c(7,11)){
  game_status <- TRUE
  point <- NA
} else {
  game_status <- NA
  point <- crap_score
}
game_status       
point


# E8-2
if (is.na(crap_score)){
while (game_status != TRUE & game_status != FALSE){
  crap_score <- two_d6(1)
  if (crap_score == 7){
    game_status <- FALSE
  } else if (crap_score == point){
    game_status <- TRUE
  }
}
}

# E8-3
sea_shells <- c(
  "She", "sells", "sea", "shells", "by", "the", "seashore",
  "The", "shells", "she", "sells", "are", "surely", "seashells",
  "So", "if", "she", "sells", "shells", "on", "the", "seashore",
  "I'm", "sure", "she", "sells", "seashore", "shells"
)

for (i in sea_shells){
  print(sprintf("%s has %d words", i, nchar(i)))
}

charNumber <- nchar(sea_shells)
for (i in min(charNumber):max(charNumber)){
  print(sprintf("%d word", i))
  print(toString(unique(sea_shells[charNumber == i])))
}

