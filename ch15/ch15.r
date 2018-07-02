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

# Plotting and inspecting models
# plot()
plot_numbers <- 1:6
layout(matrix(plot_numbers, ncol = 2, byrow = TRUE))
plot(model4, plot_numbers)
plot(model4)
plot(model1, plot_numbers)
plot(model1)

gono[c(40,41,160),]
# functions to check the model variables
str(model4)
unclass(model4)
formula(model4)
nobs(model4)
residuals(model4)
fitted(model4)
coefficients(model4)

# check the relationship betweeen residual and fitted using ggplot
diagnostics <- data.frame(  residuals = residuals(model1),
  fitted = fitted(model1))
ggplot(diagnostics, aes(fitted, residuals)) +
  geom_point() +
  geom_smooth(method = "loess")

# predict function
new_data <- data.frame(Age.Group = "30 to 34", Gender = "Male")
predict(model4, new_data)

subset(gono, Age.Group == "30 to 34" & Gender == "Male" & Year == 2006)

# 5, other model types
# glm()
# glm(true_or_false ~ some + predictor + variables, data, family = binomial()) 

## Quiz
# Q15-1
# set.seed() function set same seed, will generate same random numbers

# Q15-2
# PDF probability distr, dxxx(); CDF cumulative , pxxx(); inverse CDF qxxx()

# Q15-3
# colon : in formula model means multuple-way relationship between variables

# Q15-4
# use lm() function to build model and use anova(), AIC() and BIC() to compare

# Q15-5
# R^2 value is available via summary(model)$r.squared

## Exercises

# E15-1
# 1. Poisson distr of typo
#dpois(x, mean)
dpois(3, 3)

# 2. binomi pnbinom(q, size, prob, mu, log = FALSE)
pnbinom(12, 1, 0.25)

# 3. qbirthday
qbirthday(prob = 0.9, classes = 365, coincident = 2)

# E15-2
gono15to34 <- subset(gono, Age.Group == "15 to 19" | Age.Group == "20 to 24" |
         Age.Group == "25 to 29" | Age.Group == "30 to 34")
gono15to34
model5 <- lm(Rate ~ Year + Age.Group + Gender, gono15to34)
predict(model1, gono15to34)
summary(model5)
model6 <- update(model5, ~ . - Year)
summary(model6)

# E15-3
install.packages("betareg")
library(betareg)
data(obama_vs_mccain, package = "learningr")
head(obama_vs_mccain)

# as hint, need turn the Obama to [0,1)
obama <- obama_vs_mccain$Obama /100
obama
obama_vs_mccain$Obama <- obama

# try obama vs. maccain
bovm <- betareg(Obama ~ McCain, obama_vs_mccain)
summary(bovm)

# try obama vs. other factors
bovm1 <- betareg(Obama ~ Turnout + Population + Unemployment + Urbanization + Black + Protestant,
  obama_vs_mccain,  subset = State != "District of Columbia"
)
summary(bovm1)

# population and urbanization are not sigifincat, can be removed
bovm2 <- update(bovm1, ~ . - Population)
summary(bovm2)
bovm3 <- update(bovm2, ~ . - Urbanization)
summary(bovm3)

# plot 
plot(bovm3, plot_numbers)
plot(bovm3)

