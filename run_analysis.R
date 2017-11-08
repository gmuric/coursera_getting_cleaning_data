#Loading the train and test datasets
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")

#Extracting only the mean and std for each measurement
features <- read.table("UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)
wanted_vector <- grep(".*std.*|.*mean.*", features$V2) #finding indices where "std" or "mean" are mentioned
train_x <- train_x[,wanted_vector]
test_x <- test_x[,wanted_vector]

#merging with the rest of the data
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
all_train <- cbind(train_x, train_y, train_subject) #binding columns of wanted data with activities and subject
all_test <- cbind(test_x, test_y, test_subject)
data <- rbind(all_train, all_test) #binding rows of train and test data sets

#Appropriately labels the data set with descriptive variable names
nice_names <- gsub('[-()]', '', gsub("[-]","_",features[wanted_vector,2])) #replacing dash with underscore and removing the brackets
nice_names <- c(nice_names, "activity", "subject")
colnames(data) <- nice_names

#Uses descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <- as.character(activities[,2])
data$activity = factor(data$activity,levels = activities[,1], labels=activities[,2])

#Finding the average of each variable for each activity and each subject
library(reshape2)
melted <- melt(data, id = c("subject", "activity"))
meanData <- dcast(melted, subject + activity ~ variable, mean)

#Writing the resulting data into the tidy.txt file
write.table(meanData, "tidy.txt", row.names = FALSE, quote = FALSE)
