## Chapter 09

# Replication

rep(2, 10)
replicate(2, 10)
rep(runif(1),4)
replicate(4, runif(1))

# time of different transportation

time_for_commute <- function(){
  #Choose a mode of transport for the day
  mode_of_transport <- sample(
    c("car", "bus", "train", "bike"),
    size = 1,
    prob = c(0.1, 0.2, 0.3, 0.4)
  )
  #Find the time to travel, depending upon mode of transport
  time <- switch(
    mode_of_transport,
    car = rlnorm(1, log(30), 0.5),
    bus = rlnorm(1, log(40), 0.5),
    train = rnorm(1, 30, 10),
    bike = rnorm(1, 60, 5)
  )
  names(time) <- mode_of_transport
  time
}

# using the replicate() gives instant vectorization
replicate(5, time_for_commute())


# Loopsing over lists
prime_factors <- list(
  two = 2,
  three = 3,
  four = c(2, 2),
  five = 5,
  six = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine = c(3, 3),
  ten = c(2, 5)
)
head(prime_factors)

# hard way to do
unique_primes <- vector("list", length(prime_factors))
for(i in seq_along(prime_factors)){
  unique_primes[[i]] <- unique(prime_factors[[i]])
}
names(unique_primes) <- names(prime_factors)
unique_primes
# easy way to do using lapply()
lapply(prime_factors, unique)
# vapply
vapply(prime_factors, length, numeric(1))

# sapply
sapply(prime_factors, unique)
sapply(prime_factors, length)
sapply(prime_factors, summary)
