## Getting-and-Cleaning-Data-Course-Project

####Script Summary
1) run_analysis.R merges the training and the test sets to create one data set. 

2) Extracts only the measurements on the mean and standard deviation for each measurement. 

3) Uses descriptive activity names to name the activities in the data set 

4) Appropriately labels the data set with descriptive activity names. 

5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

####How execute run_analysis.R script

1) Download and unzip data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2) Copy run_analysis.R script to "UCI HAR Dataset" folder

3) Open RStudio and set "UCI HAR Dataset" folder as working directory.

4) In command window type *source("run_analysis.R")* and press enter to run script

5) Script will generate an output file called "data_averages.txt. 
* This file contains a tidy data set with the average of each variable for each activity and each subject
