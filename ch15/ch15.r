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

# 2, distribution
dnorm(2)
pnorm(2)
qnorm(2)

# 3, Formulae
library(xlsx)
library(ggplot2)
gonoFile <- system.file("extdata", "multi.drug.resistant.gonorrhoea.infection.xls", package = "learningr")
gono <- read.xlsx2(gonoFile, sheetIndex = 1, startRow = 1, endRow = 101,
                   colIndex = 1:4,
                   colClasses = c("numeric", "character","character", "numeric"))
gono

ggplot(gono, aes(Age.Group, Rate)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year + Gender)

ggplot(gono, aes(Age.Group, Rate)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year * Gender)

# ~ + * : ^ 
ggplot(gono, aes(Age.Group, Rate)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year : Gender)

# 4, linear regression
# lm() linear model
model1 <- lm(Rate ~ 0 + Year + Age.Group + Gender, gono)
model1

model1 <- lm(Rate ~ Year + Age.Group + Gender, gono)
model1

lapply(Filter(is.factor, gono), levels)
lapply(gono, levels)
levels(gono$Year)
levels(gono$Rate)
levels(gono$Age.Group)
levels(gono$Gender)

# summary()
summary(model1)

# compare and update model
# How to interprete the data ?
# update function
model2 <- update(model1, ~ . - Year) # remove var of year and keep others
model2
summary(model2)

# anova table
anova(model1, model2)
# this silly_model remove Age, which is high associated with Rate
silly_model <- update(model1, ~ . - Age.Group)
anova(model1, silly_model)

# Akaike information
AIC(model1, model2)
AIC(model1, silly_model)

# Bayesian information
BIC(model1, model2)
BIC(model1, silly_model)

# gender in gono may be a little associated with Rate
model3 <- update(model2, ~ . - Gender)
summary(model3)
anova(model3, model2)

# relevel function to change default group
g2 <- within(gono,
  { Age.Group <- relevel(Age.Group, "30 to 34") })
model4 <- update(model3, data = g2)
summary(model4)
