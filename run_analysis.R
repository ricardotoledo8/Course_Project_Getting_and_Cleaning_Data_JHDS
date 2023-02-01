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


# Reading data sets:
        # reading train data set
        x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                             header = FALSE)
        y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                             header = FALSE)
        subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                                   header = FALSE)
        
        # reading test data set
        x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                                    header = FALSE)
        y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                                    header = FALSE)
        subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                                          header = FALSE)
        
        # reading features
        features <- read.table("./data/UCI HAR Dataset/features.txt",
                                      header = FALSE)
        
        # reading activity labels
        activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                                             header = FALSE)
        
        # assigning variable names
        colnames(x_train) <- t(features[,2]) # matrix transpose: features
        colnames(x_test) <- t(features[,2]) # matrix transpose: features
        colnames(y_train) <- "activity_ID"
        colnames(y_test) <- "activity_ID"
        colnames(subject_train) <- "subject_ID"
        colnames(subject_test) <- "subject_ID"
        colnames(activity_labels) <- c("activity_ID", "activity_Label")

        # merging data set (length of test files is smaller than length of train files)
        all_test <- cbind(x_test, y_test, subject_test)
        all_train <- cbind(x_train, y_train, subject_train)
        
        finaldata <- rbind(all_train, all_test)
        
        # remove all data set to save memory
        rm(all_test, all_train, con, features, subject_test, 
           subject_train, x_test, x_train, y_test, y_train)
 
               

# 2) Extracts only the measurements on the mean and std desv --------

# Extracts only the measurements on the mean and standard deviation 
#        for each measurement. 
        
        # determine columns of data set to keep:
        columns_To_Keep <- grepl("subject|activity|mean|std", 
                               colnames(finaldata))

        # keep only data in these columns:
        finaldata <- finaldata[, columns_To_Keep]
        

        
# 3) Uses descriptive activity names to name the activities --------
# Use descriptive activity names to name the activities in the data set
        
        # replace activity values with named factor levels
        finaldata$activity_ID <- factor(finaldata$activity_ID, 
                                        levels = activity_labels[, 1], 
                                        labels = activity_labels[, 2])
        


# 4) Appropriately label the data set with descriptive variable --------
# Appropriately label the data set with descriptive variable names

        # get column names from finaldata
       finaldata_Col <- colnames(finaldata)
        
        # remove special characters from column names
        finaldata_Col <- gsub("[\\(\\)-]", "", finaldata_Col)
        
        # expand abbreviations and clean up names from column names
        finaldata_Col <- gsub("^f", "frequencyDomain", finaldata_Col)
        finaldata_Col <- gsub("^t", "timeDomain", finaldata_Col)
        finaldata_Col <- gsub("Acc", "Accelerometer", finaldata_Col)
        finaldata_Col <- gsub("Gyro", "Gyroscope", finaldata_Col)
        finaldata_Col <- gsub("Mag", "Magnitude", finaldata_Col)
        finaldata_Col <- gsub("Freq", "Frequency", finaldata_Col)
        finaldata_Col <- gsub("mean", "Mean", finaldata_Col)
        finaldata_Col <- gsub("std", "StandardDeviation", finaldata_Col)
        
        # correct typo
        finaldata_Col <- gsub("BodyBody", "Body", finaldata_Col)
        
        # use new labels as column names in finaldata
        colnames(finaldata) <- finaldata_Col



# 5) From the data set in step 4, creates a second, independent ti --------
# From the data set in step 4, creates a second, independent tidy data set with 
#        the average of each variable for each activity and each subject.
        
        # load dplyr package
        library(dplyr)
        
        # group by subject and activity and summarise using mean
        finaldata_Means <- finaldata %>% 
                group_by(subject_ID, activity_ID) %>%
                summarise_each(mean)
        
        # create file "tidy_data.txt"
        write.table(finaldata_Means, "tidy_data.txt", row.names = FALSE, 
                    quote = FALSE)       