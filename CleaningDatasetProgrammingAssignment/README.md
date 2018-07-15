## Steps to clean and integrate the train-test dataset
1. Download the fitibit dataset using URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the downloaded file
3. Extract the measurements and activity labels from the features.txt and activity_labels.txt files respectively
4. From the measuresments extracted in step 3 use only the measurements on the mean and standard deviation for each measurement
5. Appropriately label the data set with descriptive variable names by using regex on the measuremnt names.
6. Read in the input train, test and subject information from the respective files
7. Combine the columns from the activity labels, subject and the extracted measurement file for each train and test set
8. Create the final dataset by combining train and test set
9. Finally write a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

