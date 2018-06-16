## Chapter 10
# packages

# default package lattice
library(lattice)
?lattice
?dotplot

dotplot(variety ~ yield | site, data = barley, groups = year)

# Note: library() argument is NOT quoted.
# when you pass arguments to library(), you need set character.only
pkgs <- c("lattice", "utils", "rpart")
for(pkg in pkgs){
  library(pkg, character.only = TRUE)
}

