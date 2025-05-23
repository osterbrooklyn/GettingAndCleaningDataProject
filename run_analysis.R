# run_analysis.R

library(dplyr)

# 1. Download and unzip the data 
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "dataset.zip"
dataFolder <- "UCI HAR Dataset"

if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = zipFile, mode = "wb")
}

if (!dir.exists(dataFolder)) {
  unzip(zipFile)
}

# 2. Read feature names and activity labels
features <- read.table(file.path(dataFolder, "features.txt"), col.names = c("index", "feature"))
activities <- read.table(file.path(dataFolder, "activity_labels.txt"), col.names = c("id", "activity"))

# 3. Read training data
x_train <- read.table(file.path(dataFolder, "train", "X_train.txt"))
y_train <- read.table(file.path(dataFolder, "train", "y_train.txt"), col.names = "activity_id")
subject_train <- read.table(file.path(dataFolder, "train", "subject_train.txt"), col.names = "subject")

# 4. Read test data
x_test <- read.table(file.path(dataFolder, "test", "X_test.txt"))
y_test <- read.table(file.path(dataFolder, "test", "y_test.txt"), col.names = "activity_id")
subject_test <- read.table(file.path(dataFolder, "test", "subject_test.txt"), col.names = "subject")

# 5. Merge training and test data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 6. Extract only mean() and std() columns
mean_std_cols <- grep("mean\\(\\)|std\\(\\)", features$feature)
x_data <- x_data[, mean_std_cols]
colnames(x_data) <- features$feature[mean_std_cols]

# 7. Add descriptive activity names
y_data <- y_data %>%
  left_join(activities, by = c("activity_id" = "id"))

# 8. Clean variable names
names(x_data) <- gsub("\\(\\)", "", names(x_data))
names(x_data) <- gsub("-", "_", names(x_data))
names(x_data) <- gsub("^t", "time_", names(x_data))
names(x_data) <- gsub("^f", "frequency_", names(x_data))
names(x_data) <- gsub("Acc", "Accelerometer", names(x_data))
names(x_data) <- gsub("Gyro", "Gyroscope", names(x_data))
names(x_data) <- gsub("Mag", "Magnitude", names(x_data))
names(x_data) <- gsub("BodyBody", "Body", names(x_data))

# 9. Combine all data into one dataframe
full_data <- cbind(subject_data, activity = y_data$activity, x_data)

# 10. Create tidy data set with average of each variable for each activity and subject
tidy_data <- full_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# 11. Write the tidy data to a text file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

message("Done! tidy_data.txt created in your working directory.")