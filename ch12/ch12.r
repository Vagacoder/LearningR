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

# Other file types reading
# using foreign package to read SAS, Stata, SPSS  
library(foreign)
# using matlab package to read MATLAB
library(matlab)

# 5. Web Data
# world development indicator data form World Bank 
install.packages("WDI")
library(WDI)
wdi_datasets <- WDIsearch()
head(wdi_datasets)

wdi_trade_in_services <- WDI(
  indicator = "BG.GSR.NFSV.GD.ZS"
)
str(wdi_trade_in_services)

# quantmod for stock tickers
install.packages("quantmod")
library(quantmod)
options(getSymbols.auto.assign = FALSE)
microsoft <- getSymbols("MSFT")
head(microsoft)

# twittR package

# scraping web pages
# using read.csv function and its derivatives.
salary_url <- "http://www.justinmrao.com/salary_data.csv"
salary_data <- read.csv(salary_url)
str(salary_data)
salary_data

# download the file
local_copy <- "my local copy.csv"
download.file(salary_url, local_copy)
salary_data <- read.csv(local_copy)
salary_data

# using RCurl pkg for data inside the HTML and XML
install.packages("RCurl")
library(RCurl)
time_url <- "http://tycho.usno.navy.mil/cgi-bin/timer.pl"
time_page <- getURL(time_url)
cat(time_page)

# after RCurl read the web page, using htmlParse in XML pkg
# then split using "\n" for lines, and "\t" for different fields
time_doc <- htmlParse(time_page)
time_doc
pre <- xpathSApply(time_doc, "//pre")[[1]]
pre
values <- strsplit(xmlValue(pre), "\n")[[1]][-1]
values
strsplit(values, "\t+")

# httr pkg
library(httr)
time_page <- GET(time_url)
time_page
time_doc <- content(page, useInternalNodes = TRUE)
time_doc

# 6. Accessing database
# SQLite database
# need 2 pkg
install.packages("DBI")
install.packages("RSQLite")
library(DBI)
library(RSQLite)
# define a database driver, type is "SQLite"
driver <- dbDriver("SQLite")
# read a database file
db_file <- system.file(
  "extdata",
  "crabtag.sqlite",
  package = "learningr"
)
# connect the database driver and database file
conn <- dbConnect(driver, db_file)

# MySQL
install.packages("RMySQL")
library(RMySQL)
driver <- dbDriver("MySQL")
db_file <- "path/to/MySQL/database"
conn <- dbConnect(driver, db_file)

query <- "SELECT * FROM IdBlock"
(id_block <- dbGetQuery(conn, query))

# close the connection
dbDisconnect(conn)
dbUnloadDriver(driver)

# to ensure close the connection, wrap into a function and use "on.exit"
query_crab_tag_db <- function(query)
{
  driver <- dbDriver("SQLite")
  db_file <- system.file(
    "extdata",
    "crabtag.sqlite",
    package = "learningr"
  )
  conn <- dbConnect(driver, db_file)
  on.exit(
    {
      #this code block runs at the end of the function,
      #even if an error is thrown
      dbDisconnect(conn)
      dbUnloadDriver(driver)
    }
  )
  dbGetQuery(conn, query)
}

query_crab_tag_db("SELECT * FROM IdBlock")

# dbreadTable function
dbReadTable(conn, "idblock")

## Quiz
# Q12-1
data()
data(package = .packages(TRUE))

# Q12-2
# read.csv() use a comma as default separator, and assume a head row
# read.csv2() use a comma for decimal place and semicolon as separator.

# Q12-3
# use read.xlsx() or read.xlsx2() to read Excel spreadsheet.

# Q12-4
# read.table() and read.csv() can access the web file
# down.file() can download file.

# Q12-5
# DBI support databases of MySQL, SQLite and Oracle database

## Exercises
library(learningr)
# E12-1
hafuFile <- system.file("extdata", "hafu.csv", package = "learningr")
hafuData <- read.csv(hafuFile)
head(hafuData)
hafuData

# E12-2
library(xlsx)
infectionFile <- system.file("extdata", 
"multi.drug.resistant.gonorrhoea.infection.xls", package = "learningr")
infectionData <- read.xlsx2(infectionFile, 1 
 #, colClasses = C("integer", "character", "character", "numeric")
 )
infectionData

# E12-3
library(DBI)
library(RSQLite)
SQLiteDriver <- dbDriver("SQLite")
daylongFile <- system.file("extdata", "crabtag.sqlite", package = "learningr")
conn <- dbConnect(SQLiteDriver, daylongFile)

# method 1, read using dbReadTable()
head(dbReadTable(conn, "Daylog"))

# method 2, read using SQL command
query <- "SELECT * FROM Daylog"
head(daylog <- dbGetQuery(conn, query))

dbDisconnect(conn)
dbUnloadDriver(SQLiteDriver)
