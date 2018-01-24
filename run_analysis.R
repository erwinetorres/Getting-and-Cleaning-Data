##############################################################
##COURSERA GETTING AND CLEANING DATA ASSIGNMENT COURSE PROJECT
##Erwin Torres
##January 2018
##############################################################

#PRELIMINARY PROCEDURES
getwd()
setwd('C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset')

#Read test data
x_test <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

#Read test data
x_train <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

#Read variable descriptions
variable_names <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/features.txt")

#Read activity lables
activity_labels <- read.table("C:/Users/Acer/Documents/DATA SCIENCE_DOST and COURSERA/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")

#PROGRAMMING TASKS
# 1. Merges the training and the test sets to create one data set.
x_traintest <- rbind(x_train, x_test)
y_traintest <- rbind(y_train, y_test)
sub_traintest <- rbind(sub_train, sub_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
mean_stdev <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
x_traintest <- x_traintest[,mean_stdev[,1]]

# 3. Use descriptive activity names to name the activities in the data set
colnames(y_traintest) <- "activity"
y_traintest$activitylabel <- factor(y_traintest$activity, labels = as.character(activity_labels[,2]))
activitylabel <- y_traintest[,-1]

# 4. Appropriately label the data set with descriptive variable names.
colnames(x_traintest) <- variable_names[mean_stdev[,1],2]

# 5. From the data set in step 4, create a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(sub_traintest) <- "subject"
total <- cbind(x_traintest, activity_labels, sub_traintest)
mean_activities <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(mean_activities, file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)

#END
###################################################################################################
