## STEP 1 - Merge the training and the test sets to create one data set.
# read test data files
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
# append subject list and activity labels to test data
xtestfull<-cbind(subtest, ytest, xtest)

# read train data files
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt") 
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt") 
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
# append subject list and activity labels to train data
xtrainfull<-cbind(subtrain, ytrain, xtrain) 

# merge train and test data to single data set of all subjects
mergeddata<-rbind(xtrainfull, xtestfull) 



## STEP 2 - Extract mean and standard deviation for each measurement.
# read features.txt to extract column no.s with mean() and std() measurements
features<-read.table("./UCI HAR Dataset/features.txt")
# find column nos. for mean() and std() measurements
# result vector of column no.s will be used to extract subset from dataset
meanstdcols<-features[grep("-(mean|std)\\(\\)",features[,2]),1]
# extract cols with mean() and std() measurements from mergeddata alongwith 
# subjectid and activity_label columns. Since, subjectid and activity_label 
# columns are appended to dataset, add an offset of 2 to meanstdcols 
mergedsubset<-mergeddata[,c(1,2, (meanstdcols+2))]



## STEP 3 - Use descriptive activity names to name the activities in the data set
# read activity_labels.txt to get descriptive activity names
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
# replace activity labels with descriptive activity names in mergedsubset
mergedsubset[,2] <- activity[mergedsubset[,2], 2]



## STEP 4 - Appropriately label the data set with descriptive variable names.
# extract column names from features.txt to be added to mergedsubset
# remove "()" from column names before adding to mergedsubset
columnnames<-sub("()", "", features[meanstdcols,2], fixed=TRUE)
# Add column names "subjectid" and "activity" to column names vector
columnnames<-c("subjectid", "activity", columnnames)
# add descriptive column names to dataset
colnames(mergedsubset)<-columnnames



## STEP 5 - From the data set in step 4, create a second, 
## independent tidy data set with the average of each variable for each activity 
## and each subject.

# group mergedsubset by "subjectid" and "activity".
# then take mean of each column except the columns grouped by on.
# store result in new variable named tidydataset
library(dplyr)
tidydataset <- mergedsubset %>% group_by(subjectid, activity) %>% summarise_each(funs(mean))

# write tidydataset to txt file in the working directory. 
# column header is written to file. default sep=" " is used
write.table(tidydataset, file = "tidydataset.txt", row.names = FALSE)
