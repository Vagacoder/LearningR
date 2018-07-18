## Chapter 09

# Replication

rep(2, 10)
replicate(2, 10)
rep(runif(1),4)
replicate(4, runif(1))

# time of different transportation

time_for_commute <- function(){
  #Choose a mode of transport for the day
  mode_of_transport <- sample(
    c("car", "bus", "train", "bike"),
    size = 1,
    prob = c(0.1, 0.2, 0.3, 0.4)
  )
  #Find the time to travel, depending upon mode of transport
  time <- switch(
    mode_of_transport,
    car = rlnorm(1, log(30), 0.5),
    bus = rlnorm(1, log(40), 0.5),
    train = rnorm(1, 30, 10),
    bike = rnorm(1, 60, 5)
  )
  names(time) <- mode_of_transport
  time
}

# using the replicate() gives instant vectorization
replicate(5, time_for_commute())


# Loopsing over lists
prime_factors <- list(
  two = 2,
  three = 3,
  four = c(2, 2),
  five = 5,
  six = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine = c(3, 3),
  ten = c(2, 5)
)
head(prime_factors)

# hard way to do
unique_primes <- vector("list", length(prime_factors))
unique_primes

for(i in seq_along(prime_factors)){
  unique_primes[[i]] <- unique(prime_factors[[i]])
}
unique_primes

names(unique_primes) <- names(prime_factors)
unique_primes

# easy way to do using lapply()
lapply(prime_factors, unique)
# vapply
vapply(prime_factors, length, numeric(1))

# sapply
sapply(prime_factors, unique)
sapply(prime_factors, length)
sapply(prime_factors, summary)

# source() and dir()
r_files <- dir(pattern = "\\.r$")
r_files
lapply(r_files, source)

#
complemented <- c(2, 3, 6, 18)
complemented
lapply(complemented, rep.int, times = 3)
rep.int(complemented, times = 3)

#
rep4x <- function(x) rep.int(4, times = x)
lapply(complemented, rep4x)

#
lapply(complemented, function(x) rep.int(4, times = x))

# eapply()
env <- new.env()
env$molien <- c(1, 0, 1, 0, 1, 1, 2, 1, 3) 
env$larry <- c("Really", "leery", "rarely", "Larry")
eapply(env, length)
lapply(env, length)

## looping over arrays
# install and load matlab package
install.packages("matlab")
library(matlab)

# to unload matlab package
detach("package:matlab")

# magic() to create magic square
(magic4 <- magic(4))

# apply()
rowSums(magic4)
colSums(magic4)
sum(diag(magic4))

# parameter 1 for row, 2 for column
apply(magic4, 1, sum)
apply(magic4, 2, sum)
apply(magic4, 1, toString)
apply(magic4, 2, toString)

# apply() on data frame
(baldwins <- data.frame(
  name = c("Alec", "Daniel", "Billy", "Stephen"),
  date_of_birth = c(
    "1958-Apr-03", "1960-Oct-05", "1963-Feb-21", "1966-May-12"
  ),
  n_spouses = c(2, 3, 1, 1),
  n_children = c(1, 5, 3, 2),
  stringsAsFactors = FALSE
))

apply(baldwins, 1, toString)
apply(baldwins, 2, toString)

sapply(baldwins, range)

# multiple-input apply
msg <- function(name, factors){
  ifelse(
    length(factors) == 1,
    paste(name, "is prime"),
    paste(name, "has factors", toString(factors))
  )
}
mapply(msg, names(prime_factors), prime_factors)
# argument SIMPLIFY in mapply
mapply(msg, names(prime_factors), prime_factors, SIMPLIFY = FALSE)

##Instant Vectorization
# vectorize()
baby_gender_report <- function(gender){
  switch(
    gender,
    male = "It's a boy!",
    female = "It's a girl!",
    "Um..."
  )}

# doing this will throw an error, function require a scalar input,
# but we input a vector
genders <- c("male", "female", "other")
baby_gender_report(genders)

# an easy way to use vectorize function
vectorized_baby_gender_report <- Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)

## Split-apply-combine
# set frogger score, data frame
(frogger_scores <- data.frame(
  player = rep(c("Tom", "Dick", "Harry"), times = c(2, 5, 3)),
  score = round(rlnorm(10, 8), -1)
))

# split by player
(scores_by_player <- with(
  frogger_scores,
  split(score, player)
))

# apply the mean function to each elements
(list_of_means_by_player <- lapply(scores_by_player, mean))

# finally, we combine the results into a single vector, using unlist
(mean_by_player <- unlist(list_of_means_by_player))

# using tapply to combine previous 3 steps of split-apply-combine
with(frogger_scores, tapply(score, player, mean))

## plyr package
# add plyr library
install.packages("plyr")
library(plyr)
llply(prime_factors, unique)

# laply()
laply(prime_factors, length)
laply(list(),length)

# raply() replace replicate, not rapply
raply(5, runif(1))
rlply(5, runif(1))
rdply(5, runif(1))
r_ply(5, runif(1))

frogger_scores$level <- floor(log(frogger_scores$score))
frogger_scores

## ddply()
ddply(
  frogger_scores,
  .(player),
  colwise(mean) #call mean on every column except player
)

ddply(
  frogger_scores,
  .(player),
  summarize,
  mean_score = mean(score), #call mean on score
  max_level = max(level) #... and max on level
)

## Quiz
# Q9-1
# lapply(), sapply(), vapply(), eapply(), rapply(), mapply(), tapply()

# Q9-2
# lapply return a list, sapply try to return a vector, if not return a list,
# vapply return a vector as template argument.

# Q9-3
# rapply()

# Q9-4
# 1 : split by gender, then using lapply() to mean(), finally unlist()
# 2 : tapply()

# Q9-5
# **ply, first * mean origin data type, second * means resultant data type

## Excercises
# E9-1
wayans <- list(
  "Dwayne Kim" = list(),
  "Keenen Ivory" = list(
    "Jolie Ivory Imani",
    "Nala",
    "Keenen Ivory Jr",
    "Bella",
    "Daphne Ivory"
  ),
  Damon = list(
    "Damon Jr",
    "Michael",
    "Cara Mia",
    "Kyla"
  ),
  Kim = list(),
  Shawn = list(
    "Laila",
    "Illia",
    "Marlon"
  ),
  Marlon = list(
    "Shawn Howell",
    "Arnai Zachary"
  ),
  Nadia = list(),
  Elvira = list(
    "Damien",
    "Chaunt¨¦"
  ),
  Diedre = list(
    "Craig",
    "Gregg",
    "Summer",
    "Justin",
    "Jamel"
  ),
  Vonnie = list()
)
wayans
# how many children in first generation
NROW(wayans) 
# how many childre of each member of first generation
lapply(wayans, NROW)
vapply(wayans, length, integer(1))
vapply(wayans, NROW, integer(1))


# E9-2
state.x77
summary((state.x77))
vapply(state.x77, mean, numeric(1))
vapply(state.x77, summary, numeric(6))
ddply(state.x77, Population, colwise(mean))
# best answer
apply(state.x77, 2, mean)
apply(state.x77, 2, sd)

# E9-3
time_for_commute
commute_times <- replicate(1000, time_for_commute())
commute_data <- data.frame(
  time = commute_times,
  mode = names(commute_times)
)

commute_data
lapply(commute_data, unique)
with(commute_data, tapply(time, mode, quantile, prob =0.75))

