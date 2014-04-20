#############################
# Scoping rules
#############################

# determines how value is associated with free variable
# R uses lexical/static scoping (as opposed to dynamic scopint)

search() # display the order things will be searched for value to bind to symbol

# when user explicity loads a package with library,
#    it gets put right after .GlobalEnv and everything else shifts
# functions are tracked separately from non-functions, so can duplicate name

# example:
f <- function(x,y) {
    x^2 + y / z  # z not defined, therefor "free variable"
}

# values of free variables are searched for in the environment in which the
#    function was defined
# an environment is a set of (symbol,value) pairs (i.e. a name space)
# every environment, except empty, has a parent it inherits from
# parents can have multiple children
# function + environment = closure (or "function closure")

# when a free variable is encountered:
#    1. look in environment where function is defined (e.g Global Environment)
#    2. if not found there, look in parent environment (next in search list)
#    3. continue down search list
#       . . . 
#    N. if get to the empty environment, then throw an error

# In R, a function can be defined within another function (and returned)

make.power <- function(n) {
    pow <- function(x) {
        x^n   # n is a free variable within pow, but defined within parent
    }
    pow  # return the pow function
}

cube <- make.power(3)
class(cube)
cube(3)
ls(environment(cube)) # display what's in the environment for cube
get("n", environment(cube))  # this is what pow sees for the free var n

square <- make.power(2)
class(square)
square(3)
ls(environment(square)) # display what's in the environment for square
get("n", environment(square))  # this is what pow sees for the free var n

# parent frame is the environment in which a function is called

# other languages with lexical scoping:
#   - Scheme
#   - Perl
#   - Python
#   - Common Lisp (all langs converge to Lisp)


#############################
# Application optimization
#############################

# Optimization routines like optim, nlm, optimize require you to pass a function
# whose arg is a vector of parameters (e.g. a log-likelihood).
#
# The object function may depend on other things besides the args (e.g. data).
#
# When writing optimization software, it may be desireable to all certain fixed
# parameters.
#
# So write a constructor function which builds the objective function call with
# all the other environment stuff.
#
# NOTE: R Optimization functions (minimize). If you want to maximize, optimize
# the inverse.

# example: Maximizing a normal likelihood (i.e. minimize negative)
#
# 1. write the constructor function
make.NegLogLik <- function(data,fixed=c(FALSE,FALSE)){
    params <- fixed
    function(p){
        params[!fixed] <- p
        mu <- params [1]
        sigma <- params [2]
        a <- -0.5*length(data)*log(2*pi*sigma^2) # data = free var defined when called
        b <- -0.5*sum((data-mu)^2)/(sigma^2)
        -(a+b)  # negative the log likelihood so we can minimize
    }
}
# 2.1. use it to create the function to be optimized w/defaults
set.seed(1); normals <- rnorm(100,1,2)  # arbitrary, repeatable
nLL <- make.NegLogLik(normals)
nLL                   # see the resulting function
ls(environment(nLL))  # see free vars in the function's env that were defined @ making call
# 2.2. find optimal 
optim(c(mu=0, sigma=1), nLL)$par

# 3.1. see what happens when you fix sigma=2, mu=free
nLL <- make.NegLogLik(normals, c(FALSE,2))
optimize(nLL,c(-1,3))$minimum # find est of mu is 1.2

# 3.2. see what happns when you fix mu=1, sigma=free
nLL <- make.NegLogLik(normals, c(1,FALSE))
optimize(nLL,c(1e-6,10))$minimum  # find este of sigma is 1.8

# 4. plot likelihood and log likelihood in two examples
nLL <- make.NegLogLik(normals, c(1,FALSE)) # fix mu=1
x <- seq(1.7,1.9,len=100)
y <- sapply(x,nLL)
plot(x,exp(-(y-min(y))),type="l") # plot log as f(sigma)

nLL <- make.NegLogLik(normals, c(FALSE,2)) # fix sigma=2
x <- seq(0.5,1.5,len=100)
y <- sapply(x,nLL)
plot(x,exp(-(y-min(y))),type="l") # plot log as f(mu)
