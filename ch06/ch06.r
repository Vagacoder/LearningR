## Chapter 06

# new environment
an_environment <- new.env()

# assign variable to environment
an_environment[["pythag"]] <- c(12, 15, 20, 21)
an_environment$root <- polyroot(c(6, -5, 1))
assign(
  "moonday",
  weekdays(as.Date("1969/07/20")),
  an_environment
)
View(an_environment)

# retrieve variable form environment
an_environment[["pythag"]]
an_environment$root
get("moonday", an_environment)

# list environment content
ls(an_environment)
ls(envir = an_environment)
ls.str(envir = an_environment)

# exists functin
exists("pythag", an_environment)
exists("python", an_environment)

#Convert to list
(a_list <- as.list(an_environment))

# to environment
as.environment(a_list)
list2env(a_list)

# nested environment
nested_environment <- new.env(parent = an_environment)
exists("pythag", nested_environment)
exists("pythag", nested_environment, inherits = FALSE)
