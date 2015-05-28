### Informations about ```run_analysis.R```
- The code has been created in RStudio version 0.98.1103 (R version 3.1.3).
- The code has been run on windows 7 successfully.
- The code doesn't contain downloading the raw data set step. So before running the code, one should have raw data dset downloaded.

### Dependencies
- Before running the code, one should have ```plyr``` and ```data.table``` packages installed in R.

###```run_analysis.R``` does the following to get the tidy data set:
- Loads plyr and data.table packages.
- Reads "X_train.txt" , "X_test.txt" , "y_test.txt" , "y_train.txt" , "features.txt" data
- Merges test and train data
- Extracts the mean and standard deviation column names.
- Measures the mean of each variable for each activity and each subject.

### How to get tidy data from ```run_analysis.R```
- 1- Download the raw data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip link.
- 2- Unzip the downloaded file. After that, you should have a folder named "UCI HAR Dataset".
- 3- Put ```run_analysis.R``` in the same directory as "UCI HAR Dataset" folder. Using the code  ```setwd()``` set that directory as your working directory in R or RStudio. 
- 4- Run ```source("run_analysis.R")``` in R or RStudio, then it'll create a text file named tidy.txt in your working directory which contains the tidy data.  

 ### To read the tidy data created by ```run_analysis.R``` into R or RStudio run the following code:
- ```library(data.table)```
- ```read.table("tidy.txt",header=T,check.names=F)```

