## This is the code book for Getting and Cleaning Data course project 

The goal is to prepare tidy data that can be used for later analysis. 


### How to get to the tinyData.txt:

About the source data
The source data are from the Human Activity Recognition Using Smartphones Data Set. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Download data from the link and unzip it into working directory of R Studio.


### R script
The R code "run_analysis.R" assumes all the data is present in the same folder, un-compressed and without names altered.
And it performs 5 steps above:


#### 1) Reading in the files and merging the training and the test sets to create one data set:

1.1) Reading data set

1.2) Reading trainings data

1.3) Reading testing data

1.4) Reading feature vector

1.5) Reading activity labels

1.6) Assigning variable names

1.7) Merging all data

1.8) Merging the all test data

1.9) Merging all train data

1.10) Merging all test and all train data in one data set called *finaldata*

1.11) Removing temporary data sets to save memory



#### 2) Extracting only the measurements on the mean and standard deviation for each measurement
2.1) Using grepl function for column names in *finaldata* and keep only mean and standard deviation data



#### 3) Using descriptive activity names to name the activities in the data set
3.1) Replace the column activity_ID of activity values with named factor levels and labels



#### 4) Appropriately labeling the data set with descriptive variable names
4.1) Cleaning special characters from column names of *finaldata*

4.2) Expanding abbreviations from column names of *finaldata*



#### 5) Creating a second, independent tidy data set with the average of each variable for each activity and each subject
5.1) Using *dplyr* package

5.2) Making the second tidy data set group by subject and activity Ids and summarise using mean function

5.3) Writing the second tidy data set in *tidy_data.txt*

----------------------

### About variables and data sets:
*x_train, y_train, x_test, y_test, subject_train* and *subject_test* contain the data from the downloaded files.

*all_test, all_train* and *finaldata* merge the previous datasets to further analysis.

*features* contains the correct names for the *x_train* and *x_test* dataset, which are applied to the column names stored in.

*activity_labels* contains the id and activity names for activities.

*tidy_data.txt* the output of R Script with the tidy data set.
