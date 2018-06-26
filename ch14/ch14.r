## Chapter 14
# 1. Summary Statistics
# e.g. obama vs mccain
data(obama_vs_mccain, package = "learningr")
obama_vs_mccain

# mean() andf median()
obama <- obama_vs_mccain$Obama
mean(obama)
median(obama)

# table()
table(cut(obama, seq.int(0, 100,10)))

# var() and sd()
var(obama)
sd(obama)
mad(obama)

# min(), max(), range(), pmin() and pmax()
min(obama)
range(obama)
pmin(obama_vs_mccain$Obama, obama_vs_mccain$McCain)

with(obama_vs_mccain, pmin(Obama, McCain))
with(obama_vs_mccain, Obama > 60)

# cummin() and cummax()
cummin(obama)
cummax(obama)

# cumsum() and cumprod()
cumsum(obama)
cumprod(obama)

# quantile function
quantile(obama)
quantile(obama, type = 5)
quantile(obama, c(0.6, 0.75, 0.90))
fivenum(obama)

# IQR = Q3 - Q1
IQR(obama)

# summary()
summary(obama_vs_mccain)

# cor() and cancor()
with(obama_vs_mccain, cor(Obama, McCain))
with(obama_vs_mccain, cancor(Obama, McCain))

# 2. Three plotting system
# base, grid, lattice and ggplot2

# scatterplots
# e.g. 1. Obama vs McCain, correlation of income and poll
# take 1: base
# keep all variable in one data frame

# step 1, remove data whose Turnout is missed (NA)
obama_vs_mccain <- obama_vs_mccain[!is.na(obama_vs_mccain$Turnout), ]
# step 2, make a scatterplot
with(obama_vs_mccain, plot(Income, Turnout))
with(obama_vs_mccain, plot(Income, Turnout, col = "violet", pch = 20))

plot(1:25, pch = 1:25, bg = "blue")

with(obama_vs_mccain, plot(Income, Turnout, log = "y"))
with(obama_vs_mccain, plot(Income, Turnout, log = "xy"))
# step 3, split data to 10 regiomn, and plot them in one layout
par(mar = c(3, 3, 0.5, 0.5), oma = rep.int(0, 4), mgp = c(2, 1, 0))
regions <- levels(obama_vs_mccain$Region)
plot_numbers <- seq_along(regions)
layout(matrix(plot_numbers, ncol = 5, byrow = TRUE))
for(region in regions){
  regional_data <- subset(obama_vs_mccain, Region == region)
  with(regional_data, plot(Income, Turnout))
}

# take 2: lattice
library(lattice)
xyplot(Turnout ~ Income, obama_vs_mccain)
xyplot(Turnout ~ Income, obama_vs_mccain, col = "violet", pch = 20)

# axis scale
xyplot(Turnout ~ Income,
  obama_vs_mccain,
  scales = list(log = TRUE) #both axes log scaled (Fig. 14-8)
)

xyplot( Turnout ~ Income,
  obama_vs_mccain,
  scales = list(y = list(log = TRUE)) #y-axis log scaled (Fig. 14-9)
)

# splir data using "|"
xyplot(Turnout ~ Income | Region,
  obama_vs_mccain,
  scales = list(
    log = TRUE,
    relation = "same",
    alternating = FALSE
  ),
  layout = c(5, 2)
)

# xyplot() result can be stored in variable
(lat1 <- xyplot(Turnout ~ Income | Region,
  obama_vs_mccain
))
# then update the variable to update the plot
(lat2 <- update(lat1, col = "violet", pch = 20))

# take 3: ggplot
library(ggplot2)
ggplot(obama_vs_mccain, aes(Income, Turnout)) + geom_point()
ggplot(obama_vs_mccain, aes(Income, Turnout)) +
  geom_point(color = "violet", shape = 1)

