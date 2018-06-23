## Chapter 13
# 1. Cleaning and Tranformation

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

# string split
str_split(english_monarchs$name[multiple_rulers], ", ?")
individual_rulers <- str_split(english_monarchs$name, ", | and ")
individual_rulers

# character count
th <- c("th", "ð", "þ")
th

str_count(english_monarchs$name, "Offa")
sum(str_count(english_monarchs$name, "Offa"), na.rm = TRUE)

sapply(th, function(x){sum(str_count(english_monarchs$name, x), na.rm = TRUE)})

# replace character
english_monarchs$new_name <- str_replace_all(english_monarchs$name, "[ðþ]", "th")
english_monarchs$new_name

# unify all variant low- and upper-case string
library(plyr)
gender <- c("MALE", "Male", "male", "M", "FEMALE",
            "Female", "female", "f", NA)
gender

# Somehow the syntax from textbook does not work
# I improve regex "(?i)xxxx(?-i)" to ignore the case of xxxx.
clean_gender <- str_replace(gender, "(?i)^m(ale)?$(?-i)", "Male")
clean_gender
clean_gender <- str_replace(clean_gender, "(?i)^f(emale)?$(?-i)", "Female")
clean_gender

# 2. Manipulate Data Frame
# add/ replace columns (using indexing / subset)
head(english_monarchs)
english_monarchs$length.of.reign.years <-
  english_monarchs$end.of.reign - english_monarchs$start.of.reign
head(english_monarchs)

# add/ replace columns (using with function)
english_monarchs$length.of.reign.years <- with(
  english_monarchs,
  end.of.reign - start.of.reign
)
head(english_monarchs)

# within function return whole data frame
english_monarchs <- within(  english_monarchs,  {
    length.of.reign.years <- end.of.reign - start.of.reign
  }
)

# useful when changing more columns
english_monarchs <- within(  english_monarchs,
  { length.of.reign.years <- end.of.reign - start.of.reign
    reign.was.more.than.30.years <- length.of.reign.years > 30
  }
)

head(english_monarchs)

# mutate function
english_monarchs <- mutate( english_monarchs,
  length.of.reign.years = end.of.reign - start.of.reign,
  reign.was.more.than.30.years = length.of.reign.years > 30
)

# Dealing with Missing Data
data("deer_endocranial_volume", package = "learningr")
# all data
deer_endocranial_volume

# find entries which have all data 
# complete.cases function return a vector showing
# which row is free of NA
has_all_measurements <- complete.cases(deer_endocranial_volume)
deer_endocranial_volume[has_all_measurements, ]

# na.omit function is shortcut of complete.cases + indexing
na.omit(deer_endocranial_volume)

# na.fail() throw an error if there is NA
na.fail(deer_endocranial_volume)

# Converting Between wide and long form
deer_wide <- deer_endocranial_volume[, 1:5]
deer_wide

# reshape2 pkg
library(reshape2)
deer_long <- melt(deer_wide, id.vars = "SkullID")
head(deer_long)

# measure.vars argument
melt(deer_wide, measure.vars = c("VolCT", "VolBead", "VolLWH", "VolFinarelli"))

# dcast function from long to wide
deer_wide_again <- dcast(deer_long, SkullID ~ variable)
deer_wide_again
# notice that data frame is sorted by SkullID
deer_endocranial_volume
