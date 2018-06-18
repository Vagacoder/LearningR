## Chapter 10
# packages

# e.g. default package lattice
library(lattice)
?lattice
?dotplot

dotplot(variety ~ yield | site, data = barley, groups = year)

## laod package
# Note: library() argument is NOT quoted.
# when you pass arguments to library(), you need set character.only
pkgs <- c("lattice", "utils", "rpart")
for(pkg in pkgs){
  library(pkg, character.only = TRUE)
}

# require function, return TRUE or FALSE when it loads package
if(!require(apackagethatmightnotbeinstalled)){
  warning("The package 'apackagethatmightnotbeinstalled' 
          is not available.")}

## check installed packages
# search()
search()

# installed.packges
View(installed.packages())

# find location of library coming with R
R.home("library")
.Library

# find your home directory
path.expand("~")
Sys.getenv("HOME")

# if there are multiple library, use .libpaths function to list all
.libPaths()

## How to install package
# access additional repository
setRepositories()

# check available packages
View(available.packages())

# try to install packages of xts and zoo
install.packages(
  c("xts", "zoo"),
  repos = "http://www.stats.bris.ac.uk/R/"
)

install.packages("xts")

# from github need devtools package
install.packages("devtools")
library(devtools)
install_github("knitr", "yihui")

## update packages
update.packages(ask = FALSE)

## Quiz
# Q10-1
# CRAN, BioC, Rforge

# Q10-2
# requir function returns TRUE/FALSE, library raise error

# Q10-3
# library is a folder storing the files of package

# Q10-4
# .libpaths()

# Q10-5
# setIntternet2() through internet2.dll

# Exercises
# E10-1
install.packages("Hmisc")

# E10-2
install.packages("lubridate")

# E10-3
View(installed.packages())
table(installed.packages())
packageList <- installed.packages()
lapply(packageList[,"LibPath"], unique)
# lapply(packageList[,"LibPath"], rowSums)
table(packageList[,"LibPath"])
