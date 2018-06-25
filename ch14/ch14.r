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

# min(), max(), pmin() and pmax()
min(obama)
pmin(obama_vs_mccain$Obama, obama_vs_mccain$McCain)

with(obama_vs_mccain, pmin(Obama, McCain))
