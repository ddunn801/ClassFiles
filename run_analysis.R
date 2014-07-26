###  Prepare  ####
library(reshape)
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
full2$Activity[full2$Activity=="1"] <- "Walking"
full2$Activity[full2$Activity=="2"] <- "Walking_Upstairs"
full2$Activity[full2$Activity=="3"] <- "Walking_Downstairs"
full2$Activity[full2$Activity=="4"] <- "Sitting"
full2$Activity[full2$Activity=="5"] <- "Standing"
full2$Activity[full2$Activity=="6"] <- "Lying"


###  Include subjects  ####
setwd(paste0(wd,"\\test"))
subtest0 <- read.table(file="subject_test.txt",header=FALSE,stringsAsFactors=FALSE)
setwd(paste0(wd,"\\train"))
subtrain0 <- read.table(file="subject_train.txt",header=FALSE,stringsAsFactors=FALSE)
subs0 <- data.frame(rbind(subtest0,subtrain0))
colnames(subs0) <- "Subject"
full3 <- cbind(full2,subs0)


###  Summarize to average for each Activity/Subject  ####
melt0 <- melt(full3,id.vars=c("Activity","Subject","Set"))
cast0 <- cast(melt0,Activity+Subject+Set~variable,mean)


####  Write final tidy data set  ####
setwd(wd)
write.table(cast0,"tidydata.txt",sep="\t",row.names=FALSE)

