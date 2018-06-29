## Chapter 15 Distribution and Modeling

# 1, Sample function
# sample()
sample(7)
sample(20, 4)
sample(10,11) # this is wrong, default replace = FALSE
sample(10,11, replace = TRUE)
# sample from color scheme (it is a vector)
colors()
sample(colors(), 5)
# sample from leap seconds (it is a vector as well)
.leap.seconds
sample(.leap.seconds, 4)
# to change the probability, using prob = vector of weight
month.abb
weights <- c(1, 1, 2, 3, 5, 8, 13, 21, 8, 3, 1,100000)
sample(month.abb, 1)
sample(month.abb, 1, prob = weights)

# sample from distribution
runif(5)
runif(5, 1, 10)
rnorm(5)
rnorm(5, 10, 7)

RNGkind()
# set.seed()
set.seed(1)
runif(5)
runif(5)
set.seed(1)
runif(5)
runif(5)
