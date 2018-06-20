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
testFile <- system.file("Z:/R/LearningR/ch11/ch11.r")
testData <- read.table(testFile)


# e.g. crab data
crab_file <- system.file("extdata", "crabtag.csv", package = "learningr")

# notice arguments: skip and nrow.
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

# write file
write.csv(
  crab_lifetime_notebook, "Z:/R/crab_lifetime_data.csv",
  row.names = FALSE,
  fileEncoding = "utf8"
)

# 2.2 Unstructured text files
text_file <- system.file(
  "extdata",
  "Shakespeare.s.The.Tempest..from.Project.Gutenberg.pg2235.txt",
  package = "learningr"
)
text_file
the_tempest <- readLines(text_file)
the_tempest
the_tempest[1926:1927]

# 2.3 XML and HTML files
install.packages("XML")
library(XML)
# using internal nodes
xml_file <- system.file("extdata", "options.xml", package = "learningr")
xml_file
r_options <- xmlParse(xml_file)
r_options

# using R nodes
xmlParse(xml_file, useInternalNodes = FALSE)
xmlTreeParse(xml_file)

# using XPath to search node 
xpathSApply(r_options, "//variable[contains(@name, 'warn')]")

# serializing objects
install.packages("Runiversal")
library(Runiversal)
ops <- as.list(options())
cat(makexml(ops), file = "options.xml")

# 3. JSON and YAML files
install.packages("RJSONIO")
install.packages("rjson")
library(RJSONIO)
library(rjson)

jamaican_city_file <- system.file(
  "extdata",
  "Jamaican.Cities.json",
  package = "learningr"
)
jamaican_city_file

# :: define from which pkg the function should be used
(jamaican_cities_RJSONIO <- RJSONIO::fromJSON(jamaican_city_file))
(jamaican_cities_rjson <- rjson::fromJSON(file = jamaican_city_file))

# 2 pkg deal with NaN and NA
special_numbers <- c(NaN, NA, Inf, -Inf)
# RJSONIO turn NaN and NA to null
RJSONIO::toJSON(special_numbers)
# rjson turn everything to string
rjson::toJSON(special_numbers)


# YAML package
library(yaml)
yaml.load_file(jamaican_city_file)

# 4. Read binary file
# Excel file
install.packages("xlsx")
library(xlsx)
bike_file <- system.file(
  "extdata",
  "Alpe.d.Huez.xls",
  package = "learningr"
)
bike_file

# coClasses is optional, helping to set data type.
bike_data <- read.xlsx2(
  bike_file,
  sheetIndex = 1,
  startRow = 2,
  endRow = 38,
  colIndex = 2:8,
  colClasses = c(
    "character", "numeric", "character", "integer",
    "character", "character", "character"
  )
)
head(bike_data)

