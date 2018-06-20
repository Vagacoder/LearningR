## Chapter 11
# Data and times
install.packages("lubridate")
library(lubridate)

# POSIX dates and times
(now_ct <- Sys.time())
class(now_ct)
unclass(now_ct)

(now_lt <- as.POSIXlt(now_ct))
class(now_lt)
unclass(now_lt)

# using index to acces each elemetn in POSIXlt
now_lt
now_lt$sec
now_lt$min
now_lt["min"]
now_lt[["zone"]]

# date class
(now_date <- as.Date(now_ct))
class(now_date)
unclass(now_date)

## parse the date and time from and to string
# strptime() return POSIXlt format
moon_landings_str <- c(
  "20:17:40 20/07/1969",
  "06:54:35 19/11/1969",
  "09:18:11 05/02/1971",
  "22:16:29 30/07/1971",
  "02:23:35 21/04/1972",
  "19:54:57 11/12/1972"
)

(moon_landings_lt <- strptime(
  moon_landings_str,
  "%H:%M:%S %d/%m/%Y",
  tz = "UTC"
))

# if format does not match, will return NA
strptime(
  moon_landings_str,
  "%H:%M:%S %d-%m-%Y",
  tz = "UTC"
)

## formatting dates
# strftime()
strftime(now_ct, "It's %I:%M%p on %A %d %B, %Y.")
strftime(now_ct, "It's %H:%M%p on %A %d %m, %Y.")

## time zone
# default time zone
Sys.timezone()
Sys.getlocale()
Sys.getlocale("LC_TIME")

# use Olson form ("Coutinent/City")
strftime(now_ct, tz = "America/Los_Angeles")
strftime(now_ct, tz = "Africa/Brazzaville")
strftime(now_ct, tz = "Asia/Kolkata")

file.path(R.home("share"),"zoneinfo", "zone.tab")

# manual offset from UTC
strftime(now_ct, tz = "")
strftime(now_ct, tz = "UTC")
strftime(now_ct, tz = "UTC-5")
strftime(now_ct, tz = "GMT-5")
strftime(now_ct, tz = "-5")

# using abbreviation
strftime(now_ct, tz = "EST")
strftime(now_ct, tz = "PST")
strftime(now_ct, tz = "PST8PDT")

strftime(now_ct, tz = "Asia/Tokyo")

# strftime() ignore the time zone change for POSIXlt date
now_lt
strftime(now_lt, tz = "Asia/Tokyo")
strftime(as.POSIXct(now_lt), tz = "Asia/Tokyo")

## Arithmetic on dates and times
now_ct + 86400
now_lt + 86400
now_date + 1

(the_start_of_time <- as.Date("1970-01-01"))
(the_end_of_time <- as.Date("2012-12-21"))
(all_time <- the_end_of_time - the_start_of_time)
class(all_time)
unclass(all_time)
difftime(the_end_of_time, the_start_of_time, units = "secs")
difftime(the_end_of_time, the_start_of_time, units = "weeks")

seq(the_start_of_time, the_end_of_time, by = "1 year")
seq(the_start_of_time, the_end_of_time, by = "500 days")

# check the methods in the classes of POSIX and Date
methods(class = "POSIXt")
methods(class = "Date")

# lubridate package
methods(class = "lubridate")
john_harrison_birth_date <- c( #He invented the marine chronometer
  "1693-03 24",
  "1693/03\\24",
  "Tuesday+1693.03*24"
)
ymd(john_harrison_birth_date)

date_format_function <-
  stamp("A moon landing occurred on Monday 01 January 1900 at 18:00:00.")

## Duration and Period
# duration
(duration_one_to_ten_years <- dyears(1:10))
?dyears
today() + duration_one_to_ten_years
dminutes(100)
# period
years(1:10)
(period_one_to_ten_years <- years(1:10))
today() + period_one_to_ten_years
# interval
a_year <- dyears(1)
as.period(a_year)

start_date <- ymd("2016-02-28")
(interval_over_leap_year <- new_interval(
  start_date,
  start_date + a_year
))
as.period(interval_over_leap_year)

# interval operator %--% and %within%
ymd("2016-02-28") %--% ymd("2016-03-01")
ymd("2016-02-27") %within% interval_over_leap_year
ymd("2016-02-29") %within% interval_over_leap_year

# change time zone using with_tz function
now_lt
with_tz(now_lt, tz = "America/Los_Angeles")
with_tz(now_lt, tz = "Africa/Brazzaville")
with_tz(now_lt, tz = "Asia/Kolkata")
with_tz(now_lt, tz = "Australia/Adelaide")

# olson_time_zones function
head(olson_time_zones())
olson_time_zones()
olson_time_zones("longitude")

## Quiz
# Q11-1
# POSIXct, POSIXllt (in a list), Date (no time )

# Q11-2
# orgiin is 1970-01-01

# Q11-3
current_date <- Sys.time()
strftime(current_date, "%B, %Y")

# Q11-4
current_date
(current_date + dminutes(60))
(current_date + 3600)

# Q11-5
# period is later
one_date <- as.Date("2016-01-01")
one_date
one_year_duration <- dyears(1)
one_year_period <- years(1)
(one_date + one_year_duration)
(one_date + one_year_period)

## Exercises
# E11-1
b_days <- c(as.Date("1940-07-07"), 
                    as.Date("1940-10-09"),
                    as.Date("1942-06-18"), 
                    as.Date("1943-2-25")
                    )
b_days

inputDate <- c("1940-07-07", "1940-10-09","1942-06-18","1943-2-25")
b_days2 <- strptime(inputDate, "%Y-%m-%d", tz = "UTC")
b_days2

strftime(b_days2, "%a %d %b %y")
      
# E11-2
# 1
Sys.timezone(location = TRUE)
# 1
tzFile <- file.path(R.home("share"), "zoneinfo", "zone.tab")
tzones <- read.delim(
  tzFile,
  row.names = NULL,
  header = FALSE,
  col.names = c("country", "coords", "name", "comments"),
  as.is = TRUE,
  fill = TRUE,
  comment.char = "#"
)
tzones
View(tzones)
tzones[, "name"]
tzones[, 3]
subset(tzones, name == "America/Los_Angeles")

# E11-3
# zodiac function define
zodiac <- function(inputDate){
  month <- as.numeric(strftime(inputDate, "%m"))
  day <- as.numeric(strftime(inputDate, "%d" ))
  #print(month)
  #print(day)
  
  if (month == 04) {
    if (day < 20) {sign <- "Aries"} else {sign <- "Taurus"}
  }
  if (month == 05){
    if (day < 21) {sign <- "Taurus"} else {sign <- "Gemini"}
  }
  if (month == 06){
    if (day < 21) {sign <- "Gemini"} else { sign <- "Cancer"}
  }
  if (month == 07) {
    if (day < 23) {sign <- "Cancer"} else { sign <- "Leo"}
  }
  if (month == 08) {
    if (day < 23) {sign <- "Leo"} else { sign <- "Virgo"}
  }
  if (month == 09) {
    if (day < 23) {sign <- "Virgo"} else { sign <- "Libra"}
  }
  if (month == 10) {
    if (day < 23) {sign <- "Libra"} else { sign <- "Scorpio"}
  }
  if (month == 11) {
    if (day < 22) {sign <- "Scorpio"} else { sign <- "Sagittarius"}
  }
  if (month == 12) {
    if (day < 22) {sign <- "Saggitarius"} else { sign <- "Capricorn"}
  }
  if (month == 01) {
    if (day < 20) {sign <- "Capricorn"} else { sign <- "Aquarius"}
  }
  if (month == 02) {
    if (day < 19) {sign <- "Aquarius"} else { sign <- "Pisces"}
  }
  if (month == 03) {
    if (day < 21) {sign <- "Pisces"} else { sign <- "Aries"}
  }
  print(sign)
}

# testing 
today <- Sys.Date()
today
zodiac(today)
nicolaus_copernicus_birth_date <- as.Date("1473-02-19")
nicolaus_copernicus_birth_date
zodiac(nicolaus_copernicus_birth_date)
