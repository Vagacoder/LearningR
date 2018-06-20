## Chapter 12
# Get data

# 1, Build in dataset in R
data()
data(package = .packages(TRUE))

# access the data, arguments = 1, name of dataset, 2, name of package
data("kidney", package = "survival")
head(kidney)
kidney

# 2, Read the text file
# 2.1 CSV and TDF
# read.table()
# e.g. Deer skull data
install.packages("learningr")
library(learningr)
deer_file <- system.file("extdata", "RedDeerEndocranialVolume.dlm",
                         package =  "learningr")
deer_data <- read.table(deer_file, header = TRUE, fill = TRUE)
str(deer_data, vec.len = 1)
head(deer_data)

# test read file
testFile <- system.file("C:/Users/Skuller/R/LearningR/ch11/ch11.r")
testData <- read.csv(testFile)

# e.g. crab data
crab_file <- system.file("extdata", "crabtag.csv", package = "learningr")

(crab_id_block <- read.csv(
  crab_file,
  header = FALSE,
  skip = 3,
  nrow = 2
))

(crab_tag_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 8,
  nrow = 5
))

(crab_lifetime_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 15,
  nrow = 3
))


