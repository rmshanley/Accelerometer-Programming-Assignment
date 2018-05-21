# Create a tidy data set from raw body movement data stored at:
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# The tidy data set will be called all_mean_and_std_data
# A second data set with averages by subject and activity will be called subject_activity_avgs

library(dplyr)

# directory of downloaded data
setwd('H:\\Courses\\Coursera\\Data Cleaning\\UCI HAR\\UCI HAR Dataset')

# read varaible label tables
activity_labels <- read.table('activity_labels.txt')
features <- read.table('features.txt')

# read training data tables
subject_train <- read.table('train\\subject_train.txt')
y_train <- read.table('train\\y_train.txt')
x_train <- read.table('train\\x_train.txt')

# read test data tables
subject_test <- read.table('test\\subject_test.txt')
y_test <- read.table('test\\y_test.txt')
x_test <- read.table('test\\x_test.txt')

# store an index of variables with names that contain "mean()"
mean.index <- grep("mean()", features$V2, fixed=T)
mean.colnames <- features$V2[mean.index]

# store an index of variables with names that contain "std()"
std.index <- grep("std()", features$V2, fixed=T)
std.colnames <- features$V2[std.index]


######################################################
# create a tidy training data set

# select and label the mean variables
x_train.mean <- select(x_train, mean.index)
colnames(x_train.mean) <- make.names(mean.colnames)

# select and label the std variables
x_train.std <- select(x_train, std.index)
colnames(x_train.std) <- make.names(std.colnames)

# bind the mean and std variables
train_data <- cbind(x_train.mean, x_train.std)
#train_data$num <- c(1:nrow(train_data))

# add the subjectID
train_data$subject.ID <- subject_train$V1

# add the activity ID
train_data$V1 <- y_train$V1

# add the activity label
train_data <- merge(train_data, activity_labels, by = "V1", all.x=T, sort = F)


######################################################
# create a tidy test data set

# select and label the mean variables
x_test.mean <- select(x_test, mean.index)
colnames(x_test.mean) <- make.names(mean.colnames)

# select and label the std variables
x_test.std <- select(x_test, std.index)
colnames(x_test.std) <- make.names(std.colnames)

# bind the mean and std variables
test_data <- cbind(x_test.mean, x_test.std)
#test_data$num <- c(1:nrow(test_data))

# add the subjectID
test_data$subject.ID <- subject_test$V1

# add the activity ID
test_data$V1 <- y_test$V1

# add the activity label
test_data <- merge(test_data, activity_labels, by = "V1", all.x=T, sort = F)

######################################################
# merge test and training data
all_mean_and_std_data <- rbind(train_data, test_data)
all_mean_and_std_data <- rename(all_mean_and_std_data, activity = V2)
all_mean_and_std_data <- select(all_mean_and_std_data, -V1)

######################################################
# create a second data set with avg of each variable
#  grouped by subject and activity
subject_activity_avgs <- summarise_all(group_by(all_mean_and_std_data, subject.ID, activity), mean)

write.table(subject_activity_avgs, "subject_activity_avgs.txt", row.name=FALSE)