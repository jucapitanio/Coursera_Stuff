# Check if file must be unzipped and unzip if necessary

if(!file.exists("./UCI HAR Dataset")){
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

# Reading data into R and merging training and test datasets.

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

subject_all <- rbind(subject_train, subject_test)

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

X_all <- rbind(X_train, X_test)

Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

Y_all <- rbind(Y_train, Y_test)

# Merging subject and activity to the 561 features data 

All_subject_activity <- cbind(subject_all, Y_all) 
All_data <- cbind(X_all, All_subject_activity)

# Changing column names to appropriate feature name

features <- read.table("UCI HAR Dataset/features.txt")
features$V2 <- gsub("()-", "-", features$V2, fixed=TRUE)
features$V2 <- gsub("()", "", features$V2, fixed=TRUE)
col_names <- c(as.character(features$V2), "subject", "activity")
colnames(All_data) <- col_names

# Extracting only mean and standard deviation for each measurement

mean_cols <- grep("mean", features$V2, value = FALSE, fixed = TRUE)
std_cols <- grep("std", features$V2, value = FALSE, fixed = TRUE)
cols_keep <- sort(c(mean_cols, std_cols, 562, 563))
subset_data <- subset(All_data, select=cols_keep)

# Appropriatelly labeling activity names

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
subset_data$activity <- factor(subset_data$activity, levels = activity_labels$V1, labels = as.character(activity_labels$V2))

# Creating a new data set with the average of each variable for each activity and each subject.

tidy_data <- aggregate(.~ subject + activity, data = subset_data, FUN= "mean")
write.table(tidy_data, "tidy data.txt")