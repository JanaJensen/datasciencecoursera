#############################
# Control Structures
#############################

# if, else   test condition
# for        loop fixed number of times
# while      loop while condidtion is true
# repeat     loop forever
# break      stop looping
# next       skip a loop iteration
# return     exit function

#############################
# If else
#############################

# syntax 1
if(x>3) {  # if X is greater than 3
    y <- 10  # set y to 10
} else if(x>4) {  # will never get here, but shows syntax
    y <- NA
} else {
    y <- 0  # set y to 0
}

# syntax 2 if only setting one variable
y <- if(x>3) {
    10
} else {
    0
}

#############################
# For loop
#############################

for (i in 1:10) {  # loop through sequence
    print(i)  # display the loop index
}

x <- c("a","b","c","d")  # character vector

for(i in 1:4) {  # loop 4 times
    print(x[i])    # print the ith value of the vector
}

for(i in seq_along(x)) {  # loop through the index of x
    print(x[i])
}

for(letter in x) {  # loop through the vector
    print(letter)     # letter is a local variable within this loop structure
}

# shortened syntax
for(i in 1:4) print(x[i])

#############################
# Nested for loop
#############################

x <- matrix(1:6,2,3)

for(i in seq_len(nrow(x))) {
    for(j in seq_len(ncol(x))) {
        print(x[i,j])
    }
}

#############################
# While loop
#############################

count <- 0   # initialize the variable
while(count<10) {
    print(count)
    count <- count+1  # increment counter
}
# watch out for infinite while loops!

z <- 5
while( z>=3 && z<=10) {
    print(z)
    coin <- rbinom(1,1,0.5)
    if(coin==1) {  ## random walk
        z <- z+1
    } else {
        z <- z-1
    }
}

#############################
# Repeat loop (infinite)
#############################

x0 <- 1       # initialize variables
tol <- 1e-8
repeat {
    x1 <- computeEstimate()  # non-existent function
    if(abs(x1-x0) < tol) {
        break
    } else {
        x0 <- x1
    }
}

# requires a converging algorithm
# better to set a for loop and report whether convergence was achieved

#############################
# Next
#############################

for(i in 1:100) {
    if(i<=20) {
        # skip the first 20 iterations
        next
    }
    print(i)
}
