## "Getting and Cleaning Data" Course Project
### (Summarizing Samsung Galaxy S accelerometer data)

### Setup
#### Input data files
* Download input files as specified in project description (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Extract the zip file; it will create a folder "UCI HAR Dataset". This folder will be the working directory, henceforth called WORK_DIR

#### Project source code
run_analysis.R in this repo implements the project requirements.
The method `run_analysis()` is the public method to be invoked.
Depends on the `data.table` library.

##### Description
`run_analysis()` creates a tidy data set from the Samsung data under WORK_DIR, as per the project requirements. It returns the tidy data set, and can optionally write the results to a specifed output file.

##### Usage
    run_analysis(outfile = NULL, ...)

#### Arguments
    outfile     (optional) the file to which the resulting tidy data set is to be written
    ...         arguments to pass to write.table for writing the output file (used only if outfile is specified)

#### Result
Data frame with the tidy data set; one row per subject per activity; columns with averages of all the mean, std measurements.

## Executing the run_analysis script
### Init
    setwd("<WORK_DIR>")     # set to the "UCI HAR Dataset" folder  
    library("data.table")  
    source('run_analysis.R')    # specify full path to the file  

### Examples
    tidydata <- run_analysis()  # stores result in variable  
  
    run_analysis("foo.txt")     # writes result to foo.txt (space separated is default for write.table)  
  
    tidydata <- run_analysis("foo.txt", sep=",")    # stores result in variable, and writes CSV  