## Chapter 13
# Cleaning and Tranformation

# clean string
# turn "Y"/"N" to TRUE/FALSE
library(xlsx)
yn_to_logical <- function(x){
  y <- rep.int(NA, length(x))
  y[x == "Y"] <- TRUE
  y[x == "N"] <- FALSE
  y
}

alpe <- system.file("extdata", "Alpe.d.Huez.xls", package = "learningr")
alpe
alpe_data <- read.xlsx2(alpe, sheetIndex = 1, startRow =2)
alpe_data
alpe_data$DrugUse <- yn_to_logical(alpe_data$DrugUse)
alpe_data

## e.g. English_monarchs
data(english_monarchs, package = "learningr")
head(english_monarchs)

library(stringr)

# fixed() means exact string, not a regex
multiple_kingdoms <- str_detect(english_monarchs$domain, fixed(","))
english_monarchs[multiple_kingdoms, c("name", "domain")]

# pipe character "|" means boolean "or", return a vector of boolean
multiple_rulers <- str_detect(english_monarchs$name, ",|and")
multiple_rulers

# exclude the NA from the vector
english_monarchs$name[multiple_rulers]
english_monarchs$name[multiple_rulers & !is.na(multiple_rulers)]


