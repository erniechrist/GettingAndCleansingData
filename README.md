GettingAndCleansingData
=======================
GettingAndCleansingData Course Project

Repository Contents
-------------------
run_analysis.R
DataDictionary.txt

run_analysis.R
--------------
This R script is used to generate the output file as described in the course project.

the code needs to
- Merges the training and the test sets to create one data set
- Extract only the measurements on the mean and standard deviation for each measurement
- include descriptive activity names to name the activities in the data set
- include Appropriately labels the data set with descriptive variable names
- creates a tidy data set with the average of each variable for each activity and each subject 
- output the data to a file

The source data is data collected from the accelerometers from the Samsung Galaxy S smartphone
- the original source data and full descriptions can be found at
-- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Code Details
* Please see comments in the code for more details
- the labels_activites.txt and features.txt are loaded
- a loop will then load the test and train datasets into separate data frames
-- subjects and activity numbers (y_test,y_train) are loaded
-- the measure meants X_test and X_train are loaded and the values from features.txt are used as the column headings
-- subject, activity number and activity names are added
- test and train data frames are bound together into one data frame
- a new data frame with the subject, activity and mean and standard deviation measurements is created
- dplyr library is used to group and summarise the data for a subecjta nd activity
- results are written to a file




