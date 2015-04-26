library(dplyr)
# Read in all the data into frames and combine training and test data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
x_combined <- rbind(x_train, x_test)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
subject_combined <- rbind(subject_train, subject_test)

y_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
y_combined <- rbind(y_train, y_test)

# Add descriptive column labels to the variables
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
featurelabels <- features$V2
colnames(x_combined) <- featurelabels
colnames(y_combined) <- "activity_id"
colnames(subject_combined) <- "subject_id"

#Add descriptive activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
colnames(activity_labels) <- c("activity_id", "activity_type")
y_combined_labeled <- merge(x = y_combined, y = activity_labels, by="activity_id", all.x=TRUE)

# select only the wanted columns into the final dataset
final <- cbind(subject_combined,y_combined_labeled$activity_type,x_combined[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)])
colnames(final)[2] <- "activity_type"

# use dplyr to take mean of all measurements grouped by subject_id and activity_type
avgs <- final %>% group_by(subject_id,activity_type) %>% summarise_each(funs(mean))

# Write results to file
write.table(avgs,"avgs.txt",row.names=FALSE)