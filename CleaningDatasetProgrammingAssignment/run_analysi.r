library(reshape2)

f <- "dataset.zip"

## Get the dataset using the url for dataset in a zip format. Unzip to create the input data folder
if (!file.exists(f)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url, f, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(f) 
}

# Extract the target variable and features for the train and test set
target <- read.table("UCI HAR Dataset/activity_labels.txt")
target[,2] <- as.character(target[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# There are multiple measurements present in the dataset. Only extract the columns with mean and std deviation  
# each measurement
measurements_required <- grep(".*mean.*|.*std.*", features[,2])
measurements_required.names <- features[measurements_required,2]
measurements_required.names <- gsub('-mean', 'Mean', measurements_required.names)
measurements_required.names <- gsub('-std', 'Std', measurements_required.names)
measurements_required.names <- gsub('[-()]', '', measurements_required.names)
measurements_required.names <- gsub('^f', '', measurements_required.names)
measurements_required.names <- gsub('^t', '', measurements_required.names)


# Read input files 
train_dataset <- read.table("UCI HAR Dataset/train/X_train.txt")[measurements_required]
activities_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_dataset <- cbind(subjects_train, activities_train, train_dataset)

test_dataset <- read.table("UCI HAR Dataset/test/X_test.txt")[measurements_required]
activities_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_dataset <- cbind(subjects_test, activities_test, test_dataset)

# Combine train and test datasets to build the final dataset with target variables
final_dataset <- rbind(train_dataset, test_dataset)
colnames(final_dataset) <- c("Target1", "Target2", measurements_required.names)

# turn activities & subjects into factors
final_dataset$Target2 <- factor(final_dataset$Target2, levels = target[,1], labels = target[,2])
final_dataset$Target1 <- as.factor(final_dataset$Target1)

final_dataset.melted <- melt(final_dataset, id = c("Target1", "Target2"))
final_dataset.mean <- dcast(final_dataset.melted, Target1 + Target2 ~ variable, mean)

write.table(final_dataset.mean, "tidy.txt", row.names = FALSE, quote = FALSE)