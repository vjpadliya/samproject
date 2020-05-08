========================================
GETTING AND CLEANING DATA COURSE PROJECT
========================================
The project includes the following files - 
1. R Script "run_analysis.R"
2. Codebook for the tidy data set named "CodeBook.txt"
3. Readme file explaining the script named "README.md"

The script "run_analysis.R" assumes the original SAMSUNG data set files are all in the working directory and at the same level as the script file. 

The script performs certain transformations on the original data set to generate tidy data set in following order - 

1. Merge the training and the test sets to create one data set.
    a. Read test data files.
    b. Append subjectid and activity_label to begenning of test dataset in that order
    c. Read train data files.
    d. Append subjectid and activity_label to begenning of train dataset in that order
    e. Combine train and test data in that order using rbind

2. Extract mean and standard deviation for each measurement.
    a. Read "features.txt"
    b. Extract column numbers for columns with "mean()" or "std()" in the column name
    c. Extract a subset from Step1 data set with columns - subjectid, activity_label, and columns identified in step2b.
    
3. Use descriptive activity names to name the activities in the data set
    a. Read "activity_labels.txt"
    b. Replace activity_labels in dataset from step2 with descriptive activity names
    
4. Appropriately label the data set with descriptive variable names.
    a. Extract column names from features.txt to be added to dataset from step3
    b. Remove "()" from column names before adding to dataset
    c. Add column names "subjectid" and "activity" to column names vector
    d. Add descriptive column names to dataset
    
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
    a. Load "dplyr" package
    b. Group dataset from step4 by "subjectid" and "activity".
    c. Take mean of each column except the columns grouped by on.
    d. Store result in new variable named tidydataset
    e. Write tidydataset to txt file