## This R script does the following
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names. 
## 5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Data available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Data
# Features: features.txt
# Activities labels: activity_labels.txt
#	1 WALKING
#	2 WALKING_UPSTAIRS
#	3 WALKING_DOWNSTAIRS
#	4 SITTING
#	5 STANDING
#	6 LAYING
# [Test data set]
# test/X_test.txt:	Data set
# test/y_test.txt:	Test labels
# test/subject_test.txt:	Test subjects
# [Train data set]
# train/X_train.txt:	Data set
# train/y_train.txt:	Training labels
# train/subject_train.txt:	Test subjects


# Required libraries
if (!require("reshape2")) {
  install.packages("reshape2")
}

library(reshape2)

# Get the required data from the data folder
features <- read.table("./data/features.txt",col.names=c("ID", "MeasureType"))
activities = read.table("./data/activity_labels.txt",col.names=c("ActivityID", "Activity"))

testData = read.table("./data/test/X_test.txt",header=FALSE,col.names=features$MeasureType)
trainData = read.table("./data/train/X_train.txt",header=FALSE,col.names=features$MeasureType)
testActivity = read.table("./data/test/y_test.txt",header=FALSE)
trainActivity = read.table("./data/train/y_train.txt",header=FALSE)
testSubjects = read.table("./data/test/subject_test.txt",header=FALSE,col.names=c("Subject"))
trainSubjects = read.table("./data/train/subject_train.txt",header=FALSE,col.names=c("Subject"))

# Activity names are in column 2 of activities
#activityLabels = activities

# 1. Merge the test and training set
# Bind rowsets together
x_combDataset  <- rbind(testData,trainData)
y_combActivity   <- rbind(testActivity,trainActivity)
combSubjects <- rbind(testSubjects,trainSubjects)

# 3. / 4. Label up, prettify variables
names(y_combActivity) <- "Activity"
colnames(x_combDataset) <- features[,2]

# Prettify Activities - Change the factors: id -> activity name
# ...
colnames(y_combActivity) <- "ActivityID"

y_combActivity2 <- merge(y_combActivity, activities)
y_finalActivity <- data.frame(y_combActivity2$Activity)
colnames(y_finalActivity) <- "Activity"

# 2. Extract mean and standard deviation measurements
extMeanStdev <- grep("-mean|-std",features$MeasureType)
extFeatures = x_combDataset[,extMeanStdev]
names(extFeatures) <- features[(extMeanStdev), 2]

# 1. Create complete dataset
# Bind columnsets together
reportData <- cbind(combSubjects, y_finalActivity, extFeatures)

# 5.
# Tidy dataset
meltData <- melt(reportData, id=c("Subject","Activity"))
tidyData <- dcast(meltData, Subject+Activity ~ variable, mean)

# Write the tidy dataset to a file
write.csv(tidyData, "tidyData.csv", row.names=FALSE)
