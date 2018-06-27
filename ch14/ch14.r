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
## take 1: base
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

## take 2: lattice
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

#3 take 3: ggplot
install.packages("ggplot2")
library(ggplot2)
# + geom_point() is to draw the plot
ggplot(obama_vs_mccain, aes(Income, Turnout)) + geom_point()
ggplot(obama_vs_mccain, aes(Income, Turnout)) +
  geom_point(color = "violet", shape = 20)

# + scale for axis
ggplot(obama_vs_mccain, aes(Income, Turnout)) +   geom_point() + 
  scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) +
  scale_y_log10(breaks = seq(50, 75, 5))

# + facet for split into individual panels
ggplot(obama_vs_mccain, aes(Income, Turnout)) + geom_point() +
  scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) +
  scale_y_log10(breaks = seq(50, 75, 5)) +
  facet_wrap(~ Region, ncol = 5)

# ggplot can be stored in variables
(gg1 <- ggplot(obama_vs_mccain, aes(Income, Turnout)) +    geom_point())
(gg2 <- gg1 +   facet_wrap(~ Region, ncol = 5) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1))
)

# Line plot
## base 
# load file
crab_file <- system.file("extdata", "crabtag.csv", package = "learningr")
# read csv file, Daylog part only
crab_tag <- read.csv(crab_file, header = TRUE, skip = 27)
crab_tag
# parse the string to date
crab_tag$Date <- strptime(crab_tag$Date, "%d/%m/%Y", tz = "UTC")
crab_tag
# draw scatter plot
with(crab_tag,plot(Date, Max.Depth))
# draw line plot of Max.Depth
with(crab_tag,plot(Date, -Max.Depth, type = "l", ylim = c(-max(Max.Depth), 0)))
# add a line plot of Min.Depth
with(crab_tag, lines(Date, -Min.Depth, col = "blue"))

## lattice
xyplot(-Min.Depth + -Max.Depth ~ Date, crab_tag, type = "l")

## ggplot2
# easy way to do
ggplot(crab_tag, aes(Date, -Min.Depth)) + geom_line()
ggplot(crab_tag, aes(Date)) +
  geom_line(aes(y = -Max.Depth)) +
  geom_line(aes(y = -Min.Depth))

# proper way to do
library(reshape2)
# convert the class of Date to POSIXct
crab_tag$Date <- as.POSIXct(crab_tag$Date)
class(crab_tag$Date)
# convert to long form (this is stupid!)
crab_long <- melt(
  crab_tag, id.vars = "Date", measure.vars = c("Min.Depth", "Max.Depth"))
crab_long
# finally we can draw the plots
ggplot(crab_long, aes(Date, -value, group = variable)) +
  geom_line()

# third way
ggplot(crab_tag, aes(Date, ymin = -Min.Depth, ymax = -Max.Depth)) +
  geom_ribbon(color = "black", fill = "white")

# Histograms
## base
with(obama_vs_mccain, hist(Obama))
# change the number of bins (or width of bins, or algorithmn)
with(obama_vs_mccain, hist(Obama, 4))
with(obama_vs_mccain, hist(Obama, c(20, 35, 50, 65, 80, 95)))
with(obama_vs_mccain,hist(Obama, seq.int(0, 100, 5), main = "A vector of bin edges"))
with(obama_vs_mccain, hist(Obama, "FD", main = "The name of a method"))
with(obama_vs_mccain,
     hist(Obama, nclass.scott, main = "A function for the number of bins")
)
# a function to split 50 bins
binner <- function(x){
  seq(min(x, na.rm = TRUE), max(x, na.rm = TRUE), length.out = 50)
}
binner(10)
with(obama_vs_mccain,
     hist(Obama, binner, main = "A function for the bin edges")
)

# freq argument
with(obama_vs_mccain, hist(Obama, freq = TRUE))
