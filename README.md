# Getting and Cleaning Data Course Project

This is the README file for the script run_analysis.R

The script produces the tidy data set from the given data set by performing the following transformations:
* Loading the train and test datasets
* Extracting only the mean and standard deviation for each measurement
* Merging train and test data together with the information on subjects and reported action of a subject
* Appropriately labels the data set with descriptive variable names and names the activities in the data set
* Finds the average of each variable for each activity and each subject
* Writing the resulting data into the tidy.txt file