#############################
# Components of tidy data
#############################
# Four things you should have:
#   1. raw data
#   2. a tidy data set
#   3. a code book describing each variable and its values in the tidy set
#   4. the exact recipe you use to go from 1 -> 2,3
#############################
# You know data is raw if you:
#   1. ran no software on it
#   2. did not maniplulate any numbers in it
#   3. did not remove any data
#   4. did not summarize it in any way
#############################
# The tidy data:
#   1. each variable is in one column
#   2. each different observation is in a different row
#   3. one table for each "kind" of variable
#   4. if you have multiple tables, they need join keys
# plus:
#   - include a header row with variable names
#   - make variable names human readable
#   - one file per table
#############################
# The code book:
#   1. info about variables (including units)
#   2. info about summary choices
#   3. info about experimental study design you used
# tips:
#   - common format is Word/test file
#   - "Study design" section that thoroughly describes how you collected data
#   - "Code book" section that describes each variable and its units
#############################
# The instruction list:
#   - ideally a computer script
#   - input is raw data
#   - output is processed, tidy data
#   - no parameters to the script
# for unscripted steps, provide instructions like:
#   Step 1 - take the raw file, run version 3.1.2 of summarize software with
#            parameters a=1, b=2, c=3
#   Step 2 - run the software separately for each sample
#   Step 3 - take column three of the outputfile.out for each sample and that
#            is the corresponding row in the output data set
#############################