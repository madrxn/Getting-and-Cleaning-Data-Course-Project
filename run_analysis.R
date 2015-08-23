############################################################
# Getting and Cleaning Data Course Project - run_analysis.R
# Written by: Madrxn (https://github.com/madrxn)
#
# run_analysis.R does the following steps:
# 1) Merges the training and the test sets to create one   
#    data set.
# 2) Extracts only the measurements on the mean and standard  
#    deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities 
#    in the data set.
# 4) Appropriately labels the data set with descriptive 
#    variable names.
# 5) From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each 
#    variable for each activity and each subject.
############################################################



############## STEP 1: Merg Data ###########################
#read training set and labels
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#read test set and lables
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

#read subject activities
subject_test <- read.table("test/subject_test.txt")

#binds training and test set, training and test lables and subject
join_x_data <- rbind(x_train, x_test)
join_y_data <- rbind(y_train, y_test)
join_subject_data <- rbind(subject_train, subject_test)


###### STEP 2: Extract Colums With mean() and std() #########
#read list of all features
features <- read.table("features.txt")

#subset columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
join_x_data <- join_x_data[, mean_and_std_features]

#format by removes (), captitalize M in mean, capitalize S in std, and removes "-" 
names(join_x_data) <- gsub("\\(\\)", "", features[mean_and_std_features, 2]) 
names(join_x_data) <- gsub("mean", "_Mean", names(join_x_data))
names(join_x_data) <- gsub("std", "_Std", names(join_x_data))
names(join_x_data) <- gsub("-", "", names(join_x_data)) 


####### STEP 3: Applies Descriptive Activity Names ##########
#read activitiy lables
activities <- read.table("activity_labels.txt")

#update values with activity names and renames column
join_y_data[, 1] <- activities[join_y_data[, 1], 2]
names(join_y_data) <- "activity"


###### STEP 4: Lables Data Set With Descriptive Names #######
#renames column
names(join_subject_data) <- "subject"

# bind all the data in a single data set
join_all_data <- cbind(join_x_data, join_y_data, join_subject_data)


###### STEP 5: Creates Independent Tidy Data Set ############
#load plyr library
library(plyr)
#calculate average of each variable for each activity and each subject and writes to txt file.
ave_data <- ddply(join_all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(ave_data, "data_averages.txt", row.name=FALSE)