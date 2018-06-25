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

# melt function in reshape2 pkg (reshape2 pkg is better than reshape pkg)
install.packages("reshape2")
library(reshape2)
deer_long <- melt(deer_wide, id.vars = "SkullID")
head(deer_long)

# measure.vars argument
melt(deer_wide, measure.vars = c("VolCT", "VolBead", "VolLWH", "VolFinarelli"))

# dcast function from long to wide
deer_wide_again <- dcast(deer_long, SkullID ~ variable)
deer_wide_again
class(deer_wide_again)
# notice that data frame from dcast function above, is sorted by SkullID
deer_endocranial_volume

# acast return a vector/matrix/array
deer_wide_again1 <- acast(deer_long, SkullID ~ variable)
deer_wide_again1
class(deer_wide_again1)

# using SQL
# R functions are more concise and readable than SQL
install.packages("sqldf")
library(RSQLite)
library(DBI)
library(sqldf)

# get subset from SQL file directly
subset(deer_endocranial_volume,
  VolCT > 400 | VolCT2 > 400,
  c(VolCT, VolCT2)
)

query <-  "SELECT VolCT, VolCT2 
FROM 
  deer_endocranial_volume 
WHERE
  VolCT > 400 OR
  VolCT2 > 400"
sqldf(query)

# 3. Sorting
x <- c(2, 32, 4, 16, 8)
sort(x)
sort(x, decreasing = TRUE)
sort(c("I", "shot", "the", "city", "sheriff"))
order(x)

### sort(x) = x[order(x)]
x[order(x)]

## order() is useful for data frame, 
# while sort() cannot be directly used in data frame
year_order <- order(english_monarchs$start.of.reign)
year_order
english_monarchs[year_order, ]

# arrange function form plyr pkg
library(plyr)
arrange(english_monarchs, start.of.reign)

# rank function
(x <- sample(3, 7, replace = TRUE))
rank(x)
rank(x, ties.method = "first")

# 4. Functional Programming
# Negate() returns a reversed boolean value
ct2 <- deer_endocranial_volume$VolCT2
# note the argument is.na is a function ( is.na() )
isnt.na <- Negate(is.na)
identical(isnt.na(ct2), !is.na(ct2))

# filter()
Filter(isnt.na, ct2)

# position()
Position(isnt.na, ct2)

# Map()
get_volume <- function(ct, bead, lwh, finarelli, ct2, bead2, lwh2){
#If there is a second measurement, take the average
if(!is.na(ct2)){
ct <- (ct + ct2) / 2
bead <- (bead + bead2) / 2
lwh <- (lwh + lwh2) / 2
}
#Divide lwh by 4 to bring it in line with other measurements
c(ct = ct, bead = bead, lwh.4 = lwh / 4, finarelli = finarelli)
}

measurements_by_deer <- with(
deer_endocranial_volume,
Map(
get_volume,
VolCT,
VolBead,
VolLWH,
VolFinarelli,
VolCT2,
VolBead2,
VolLWH2
)
)
head(measurements_by_deer)

# reduce()
Reduce("+", list(1, 2, 3, 4, 5))
pmax2 <- function(x, y) ifelse(x >= y, x, y)
Reduce(pmax2, measurements_by_deer)

## Quiz
# Q13-1
# step 1 file object
shake <- system.file("extdata", "Shakespeare.s.The.Tempest..from.Project.Gutenberg.pg2235.txt", package = "learningr")
shake
# step 2 read the file to lines
shake_lines <- readLines(shake)
shake_lines
# step 3 split lines to words
shake_words <- strsplit(shake_lines, ", | ")
shake_words
# step 4 count the number of "thou"
sum(str_count(shake_words, "thou"))

# Q13-2
# with(), within(), transform() and mutate()

# Q13-3
# dcast() and acast()

# Q13-4
# sort( dataframe$colname)
# order(x) first, then x[order(x)]
# arrange()

# Q13-5
# position(x > 0)
# ispositive <- functin(x) x >0
# Find(ispositive, x)
# position(ispositive, x)

## Exercises
# E13-1
# 1
hafuFile <- system.file("extdata", "hafu.csv", package = "learningr")
hafuData <- read.csv(hafuFile)
head(hafuData)
hafu_father_uncertain <- str_detect(hafuData$Father, fixed("?"))
head(hafu_father_uncertain)
hafu_mother_uncertain <- str_detect(hafuData$Mother, fixed("?"))                                
head(hafu_mother_uncertain)
hafuData$Uncertain_Father <- hafu_father_uncertain
hafuData$Uncertain_Mother <- hafu_mother_uncertain
head(hafuData)

# 2 
hafuData$Father <- str_replace(hafuData$Father, fixed("?"), "")
hafuData$Mother <- str_replace(hafuData$Mother, fixed("?"), "")
head(hafuData)

# E13-2
# this is measuring only one variable "Father", and change to long form
hafuData_long <- melt(hafuData, id.vars = "Father")
head(hafuData_long)

# this is measuring two variables, and change to long form
hafuData_long1 <- melt(hafuData, measure.vars = c("Father", "Mother"))
head(hafuData_long1)
head(hafuData)
hafuData_long1

# E13-3
common <- function(x) {
  counted <- count(x)
  sorted <- sort(counted, decreasing = TRUE)
  unique(sorted)[1:10]
}
common(hafuData$Mother)

# key is the table function
table(hafuData$Mother)
head(sort(table(hafuData$Mother), decreasing = TRUE), 10)

# count function then make a new data frame 
counted_hafu_mother <- count(hafuData$Mother)
counted_hafu_mother
ordered_hafu_mother <- order(counted_hafu_mother$freq, decreasing = TRUE)
ordered_hafu_mother
mother_table <- data.frame(
  Mother = counted_hafu_mother$x[ordered_hafu_mother],
  Count = counted_hafu_mother$freq[ordered_hafu_mother]
)
mother_table
head(mother_table, 10)

# arrange() is much easier to use 
arrange(counted_hafu_mother, desc(freq))
