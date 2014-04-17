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
