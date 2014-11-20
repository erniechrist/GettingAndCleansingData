#****************************************************************
# Step (1) of the assignment
# Merges the training and the test sets to create one data set.
#****************************************************************

#Load labels
t<-read.table("UCI HAR Dataset\\activity_labels.txt")
v_label_activity<-t[,2]
t<-read.table("UCI HAR Dataset\\features.txt")
v_label_features<-t[,2]
rm(t)

#---------------------------------------------------------------
# load test and training data sets
# a loop is used to create variables and load them for test and train
#---------------------------------------------------------------
for (folder in c("test","train"))
{

    #load X using features as the column headings
    filename<-paste("UCI HAR Dataset\\",folder,"\\X_",folder,".txt",sep="")
    list_X<-read.table(filename,col.names=v_label_features)
    # convert X to a dataframe
    df_X<-as.data.frame(list_X)

    #load subject and convert to a vector
    filename<-paste("UCI HAR Dataset\\",folder,"\\subject_",folder,".txt",sep="")
    list_subject<-read.table(filename)
    v_subject<-list_subject[,1]
    # add subject column
    df_X$subject<-v_subject

    #load y and convert to a vector
    filename<-paste("UCI HAR Dataset\\",folder,"\\y_",folder,".txt",sep="")
    list_Y<-read.table(filename)
    v_Y<-list_Y[,1]
    # add Y column
    df_X$Y<-v_Y

    # add activites column using Y and the activites labels
    df_X$activity<-v_label_activity[v_Y]

    # add a column called ob_type which will indicate if the value is from test or train
    # this may be useful later when the two dataframes are put together
    df_X$ob_type<-folder

    # create the df variable named after the test/train folder value
    assign(paste("df_X_",folder,sep=""),df_X)

    #clean up old lists and vectors
    rm(list_subject)
    rm(list_Y)
    rm(list_X)
    rm(v_subject)
    rm(v_Y)
    rm(df_X)
    rm(filename)

}

#-----------------------------------------------------------
# bind the two data frames together into one data frame
#-----------------------------------------------------------
df_X<-rbind(df_X_test,df_X_train)

# remove old variable no longer required
rm(folder)
rm(v_label_activity)
rm(v_label_features)
rm(df_X_test)
rm(df_X_train)


#****************************************************************
# Step (2)
# Extracts only the measurements on the mean and standard deviation for each measurement.
#****************************************************************
# create a vecor of columns that contain the word 'mean...' or 'std...'
v_colnum_mean_or_std<-sort(c(grep("mean\\.\\.\\.",colnames(df_X)),grep("std\\.\\.\\.",colnames(df_X))))
# create a new data frame with only the columns with mean or std in the name
df_limited<-df_X[,v_colnum_mean_or_std]
# add subject and activity labels to the data frame
df_limited$subject<-df_X[,"subject"]
df_limited$activity<-df_X[,"activity"]

# clean up old variables
rm(v_colnum_mean_or_std)
rm(df_X)

#****************************************************************
# Step (3)
# Uses descriptive activity names to name the activities in the data set
#****************************************************************
# descriptive activity names were added after original data sets were loaded
# the following line of code shows which code was used to replace activity numbers with activity labels
# df_X$activity<-v_label_activity[v_Y]

#****************************************************************
# Step (4)
# Appropriately labels the data set with descriptive variable names.
#****************************************************************
# Appropriate label names were used when data set was loaded
# the following line of code shows which code uses feature lables to assign column headings
# list_X<-read.table(filename,col.names=v_label_features)

# write the data frame out to a file
write.table(df_limited,file="results_Step4.txt", sep=" ", col.names=TRUE,row.names = FALSE)


#****************************************************************
# Step (5)
# From the data set in step 4, creates a second, independent tidy
# data set with the average of each variable for each activity and each subject.
#****************************************************************
library(dplyr)
# group table data frame by subject and activity
tdf_X<-tbl_df(df_limited)
tdf_subjects_activity <- group_by(tdf_X,subject,activity)
# caclulate the mean of each variable for each subject and activity
tdf_subjects_activity_mean<-summarise_each(tdf_subjects_activity,funs(mean))
write.table(tdf_subjects_activity_mean,file="results_Final.txt", sep=" ", col.names=TRUE,row.names = FALSE)

# clean up variables
rm(tdf_X)
rm(tdf_subjects_activity)
