## Script for Getting and Cleaning Data Course Project of John Hopkins University
#
#       This script does:
#
#       1) Merges the training and the test sets to create one data set.
#       2) Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
#       3) Uses descriptive activity names to name the activities in the data set
#       4) Appropriately labels the data set with descriptive variable names. 
#       5) From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each subject.


# Download dataset: ----------------------------------------------------------

# check if data folder exist or create it
if(!file.exists("./data")){dir.create("./data")}

# run download file from server
con <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(con, destfile = "./data/project_Dataset.zip")

# Unzip the dataset
unzip(zipfile = "./data/project_Dataset.zip", exdir = "./data")


# 1) Merges the training and the test sets --------------------------------

# using dplyr library
library(dplyr)

# Reading data sets:
# train data set
x_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/X_train.txt"))
y_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/y_train.txt"))
subject_train <- tbl_df(read.table("./data/UCI HAR Dataset/train/subject_train.txt"))

# test data set
x_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
y_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/y_test.txt"))
subject_test <- tbl_df(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))


