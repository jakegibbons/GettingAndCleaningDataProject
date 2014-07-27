# Getting and Cleaning Data project

## run_analysis.R

###Introduction
The script, run_analysis.R, will use sumarize data from the Human Activity Recognition Using Smartphones Dataset.

There are five activities in this script as follows:
1.  Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

###Input
Data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extracted into a folder called **data**.

Training and testing data is combined into one dataset, activity data is combined into one dataset, and subject data is combined into one dataset. All datasets are column bound.

###Processing
From the combined data only measures of mean and standard deviation are extracted in to a new dataset.

This data set is further processed into just mean data and written to a new file **tidyData.csv**.