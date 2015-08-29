# Create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


pkgs <- c('reshape2', 'plyr', 'ggplot2', 'dplyr', 'data.table', 'Lahman')
install.packages(pkgs)


#Library use
library(dplyr)
library(data.table)
getwd()
setwd("/Users/tommyly/Documents/MySlideRule")

# List file in UCI HAR Dataset
list.files("UCI HAR Dataset", recursive = TRUE)

# Reading Metadata

# Load feature list file
feature <- read.table("UCI HAR Dataset/features.txt", sep="", header = FALSE)

# Load activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE)


# Activtity files = y_train & y_test, features files = X_train & x_test
# Subject files = subject_train & subject_test

# Load and process X_train, y_train, and subject_train data   
training.x <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
training.y <- read.table("UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE)

# Load and process X_test, y_test, and subject_test data
test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Task 1. Merges the training and the test sets to create one data set using dplyr package. Remember to refer
# data wranling cheatsheet

# Tasks 1.1 Merge Features file
merged.x <- bind_rows(training.x, test.x) 

# Task 1.2 Merge Activity File
merged.y <- bind_rows(training.y, test.y) 

# Task 1.3 Merge Subject File
merged.subject <- bind_rows(subject_train, subject_test)

list(x = merged.x, y = merged.y, subject = merged.subject)

# Task 1.4 Naming the columnof merged.x by transposing feature.txt into column name in merged.x
#          Naming merged.y equals "Activity" and merged.suject equals "Subject"
colnames(merged.x) <- t(feature[2])
colnames(merged.y) <- "Activity"
colnames(merged.subject) <- "Subject"
completeData <- bind_cols(merged.x, merged.y, merged.subject)

# Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Task 2.1 Subset Features Name by measurement of mean and Standard Deviaion
subdataFeaturesNames<-feature$V2[grep("mean\\(\\)|std\\(\\)", feature$V2)]

# Task 2.2 Subset the data fram completeData by selected names of sub.feature
selectedNames<-c(as.character(subdataFeaturesNames), "Subject", "Activity" )
completeData <- subset(completeData, select = selectedNames)

# Task 2.3 Check the structure of data frame completeData
str(completeData)
## 3. Uses descriptive activity names to name the activities in the data set

# Task 3.1 The Activity field in completeData is originally a numeric type. Very crucial to change
# numeric to character so it can accept activity names. The activity names are taken from metada activityLabels

completeData$Activity <- as.character(completeData$Activity)
for (i in 1:6){
  completeData$Activity[completeData$Activity == i] <- as.character(activityLabels[i,2])
}

# Task 3.2, we factor activity variable, once the acitivity nams are updated
completeData$Activity <- as.factor(completeData$Activity)

# Task 3.3 Check whether the variable were actually convert
head(completeData$Activity, 30)

# Task 4. Appropriately labels the data set with descriptive variable names.

names(completeData)<-gsub("^t", "time", names(completeData))
names(completeData)<-gsub("^f", "frequency", names(completeData))
names(completeData)<-gsub("Acc", "Accelerometer", names(completeData))
names(completeData)<-gsub("Gyro", "Gyroscope", names(completeData))
names(completeData)<-gsub("Mag", "Magnitude", names(completeData))
names(completeData)<-gsub("BodyBody", "Body", names(completeData))

names(completeData)

# 5. From the data set in step 4, creates a second,
#    independent tidy data set with the average of each variable for each activity and each subject.

# 5.1 Use subject as factor variable
completeData$Subject <- as.factor(completeData$Subject)
completeData <- data.table(completeData)

# 5.2 Create tinyData as data set
tidyData <- aggregate(. ~Subject + Activity, completeData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
str(tidyData)
