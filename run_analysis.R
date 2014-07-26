###  Prepare  ####
wd <- "C:\\Users\\ddunn\\Dropbox\\DD Cloud\\Courses\\Coursera - Getting and Cleaning Data\\UCI HAR Dataset"


###  Read in files  ####
setwd(paste0(wd,"\\test"))
test0 <- read.table(file="X_test.txt",header=FALSE,stringsAsFactors=FALSE)
testlab0 <- read.table(file="y_test.txt",header=FALSE,stringsAsFactors=FALSE)

setwd(paste0(wd,"\\train"))
train0 <- read.table(file="X_train.txt",header=FALSE,stringsAsFactors=FALSE)
trainlab0 <- read.table(file="y_train.txt",header=FALSE,stringsAsFactors=FALSE)


###  Assemble into one dataset  ####
names(testlab0) <- "Activity"
test1 <- cbind(test0,testlab0)
test1$Set <- "Test"
names(trainlab0) <- "Activity"
train1 <- cbind(train0,trainlab0)
train1$Set <- "Train"

full0 <- rbind(test1,train1)
full1 <- full0
full1$Activity <- as.character(full1$Activity)
full1$Set <- as.factor(full1$Set)


###  Read in feature labels  ####
setwd(wd)
feat0 <- read.table(file="features.txt",header=FALSE,stringsAsFactors=FALSE)
feat1 <- feat0[,2]


###  Condense to mean or sd variables  ####
meansdlist <- grep("[Mm]ean|std",feat1)


###  Label variables  ####
colnames(full1) <- c(feat1,"Activity","Set")
full2 <- full1[,c(meansdlist,562:563)]


###  Label activities  ####
full1$Activity[full1$Activity=="1"] <- "Walking"
full1$Activity[full1$Activity=="2"] <- "Walking_Upstairs"
full1$Activity[full1$Activity=="3"] <- "Walking_Downstairs"
full1$Activity[full1$Activity=="4"] <- "Sitting"
full1$Activity[full1$Activity=="5"] <- "Standing"
full1$Activity[full1$Activity=="6"] <- "Lying"







#run_analysis.R
#Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 

#CodeBook.md
#Add a code book that describes the variables, the data, and any transformations 
#or work that you performed to clean up the data called CodeBook.md.

#README.md
#You should also include a README.md in the repo with your scripts.
#This repo explains how all of the scripts work and how they are connected.  



