#############################
# generating random/arbitrary data from a standard distribution
#############################

# probability distribution functions usually have 4 associated functions w/
# specific prefixes:
#   - d for density
#   - r for random number generation
#   - p for cumulative distribution - input value, get probability
#   - q for quantile - input probability, get value (inverse cum distr)

# Normal distribution:
#   rnorm - random normal numbers with a given mean and std dev
#   dnorm - evaluate normal probability density (with given mean/sd)
#           at a point or vector of points
#   pnorm - evaluate the cumulative distribution function for a normal dist
#   qnorm - evaluate quantiles for normal distribution

x <- rnorm(10)  # generate 10 numbers w/mean=0 and sd=1
x

x <- rnorm(10,20,2)  # mean=20, sd=2
summary(x)  # see, it's close

# set a seed to get a repeatable set
set.seed(1)  # any integer
rnorm(5)     # random list
rnorm(5)     # different random list
set.seed(1)  # same seed
rnorm(5)     # same list as before

# Gamma distribution:
#   rgamma, dgamma, pgamma, qgamma

# Binary distribution: (e.g. gender, treatment/control)
#   rbinom, dbinom, pbinom, qbinom

# Poisson distribution: (w/rate)
#   rpois, dpois, ppois, qpois

str(rpois)
rpois(10,1)  # 10 variables with rate of 1
rpois(10,2)  # rate of 2
rpois(10,20) # rate of 20

str(ppois)
ppois(2,2)  # cumulative distribution, probability that x <= 2 w/rate of 2
ppois(4,2)  # Pr(x<=4) w/rate of 2
ppois(6,2)  # Pr(x<=6) w/rate of 2


#############################
# generating random/arbitrary data from a linear model
#############################

# simulate y = A + B*x + E where:
#   - E is noise with a normal dist and sd=2 (E ~ N(0,2^2))
#   - assume x ~ N(0,1^2), A = 0.5, B = 2
set.seed(20)  # arbitrary, but repeatable for x and e
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)

# what if x is binary? (gender, treatment/control)
set.seed(10)  # arbitrary, but repeatable
x <- rbinom(100,1,0.5)  # Pr(1) = 1/2
e <- rnorm(100,0,2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)  # x binary, y continuous normal

# what if y is count data rather than continuous?
# simulate a Poisson model where:
#   - y ~ Poisson(u)
#   - log(u) = A + B*x
#   - A=0.5, B=0.3
set.seed(1)  # arbitrary, but repeatable
x <- rnorm(100)
log.mu <- 0.5 + 0.3*x
y <- rpois(100,exp(log.mu))
summary(y)
plot(x,y)  # result still linear, but not continuous


#############################
# random sampling
#############################
set.seed(1)
sample(1:10,4)    # pull 4 numbers randomly from the sequence
sample(1:10,4)    # get different numbers, but still repeatable
sample(letters,5)
sample(1:10)      # random ordering of fixed set (permuttion)
sample(1:10, replace=TRUE) # can get duplicates
