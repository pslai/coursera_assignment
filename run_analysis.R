# Assignment for Getting and Cleaning Data Week 3

#set working directory
home.path <- "~/Dropbox/Coursera/GettingAndCleaningData/assignment"
setwd(home.path)

#download data from the internet 
date_download <- date()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile=file.path(home.path, "dataset.zip"))
unzip(file.path(home.path, "dataset.zip"))
rawdata.path <- file.path(home.path, "UCI HAR Dataset")
list.files(rawdata.path)


#make a tidydata folder
if(!file.exists(file.path(home.path, "tidydata"))) {dir.create("tidydata")}
tidydata.path <- file.path(home.path, "tidydata")

#looking at the data
list.files(file.path(rawdata.path, "train"))
list.files(file.path(rawdata.path, "train/Inertial Signals"))
  #per community forums, sounds like we can ignore data in this folder as it has the raw data

list.files(file.path(rawdata.path, "test"))

#read in feature names
fname = read.table(file.path(rawdata.path, "features.txt"), row.names=1, sep="", header=FALSE)


#read in activity labels
aname = read.table(file.path(rawdata.path, "activity_labels.txt"), row.names=1, sep="", header=FALSE)

#y is a vector, categorical variable for activity, range from 1-6
#x is a data frame of 561 features measured in experiment, label is fname
# subject is vector, subjid for each subject, range from 1-30

subject1 = read.table(file.path(rawdata.path,"train/subject_train.txt"), sep="", header=FALSE)
colnames(subject1) = "subjid"

x1 = read.table(file.path(rawdata.path, "train/X_train.txt"), sep="", header=FALSE)
colnames(x1) <- fname[,1]
y1 = read.table(file.path(rawdata.path, "train/Y_train.txt"), sep="", header=FALSE)
colnames(y1) <- "activity"
#making informative activity variable called act.name
act.name1 <- y1
act.name1[act.name1==1] <- "WALKING"
act.name1[act.name1==2] <- "WALKING_UPSTAIRS"
act.name1[act.name1==3] <- "WALKING_DOWNSTAIRS"
act.name1[act.name1==4] <- "SITTING"
act.name1[act.name1==5] <- "STANDING"
act.name1[act.name1==6] <- "LAYING"

train <- cbind(subject1, act.name1, x1)

subject2 = read.table(file.path(rawdata.path,"test/subject_test.txt"), sep="", header=FALSE)
colnames(subject2) = "subjid"

x2 = read.table(file.path(rawdata.path, "test/X_test.txt"), sep="", header=FALSE)
colnames(x2) <- fname[,1]
y2 = read.table(file.path(rawdata.path, "test/Y_test.txt"), sep="", header=FALSE)
colnames(y2) <- "activity"
#making informative activity variable called act.name2
act.name2 <- y2
act.name2[act.name2==1] <- "WALKING"
act.name2[act.name2==2] <- "WALKING_UPSTAIRS"
act.name2[act.name2==3] <- "WALKING_DOWNSTAIRS"
act.name2[act.name2==4] <- "SITTING"
act.name2[act.name2==5] <- "STANDING"
act.name2[act.name2==6] <- "LAYING"
names(act.name2)

test <- cbind(subject2, act.name2, x2)

all <- rbind(train, test)

#make smaller dataset with only features that represent mean and std
data1 <- all[, colnames(all)[grep("mean|std|subjid|activity", colnames(all))]]

#make second independent dataset with average of each variable for each activity and each subject
library(plyr)
data2 <- ddply(data1, .(subjid, activity), numcolwise(mean))
colnames(data2)[3:81] <- paste(colnames(data2)[3:81], "summarized", sep="-")

write.table(data1, file.path(tidydata.path, "data1.txt"), sep="\t")
write.table(data2, file.path(tidydata.path, "data2.txt"), sep="\t")
