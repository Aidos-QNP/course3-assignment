# sorry for my English!
# My Github: https://github.com/Aidos-QNP/course3-assignment

# step 0, exploring data sets with read.table(), 
pthTs_subj <- "test/subject_test.txt" # 2947x1 2-24 indexes
pthTr_subj <- "train/subject_train.txt" # 7352x1 1-30 indexes
pthTs_x <- "test/X_test.txt" # 2947x561 values (measurements?)
pthTs_y <- "test/y_test.txt" # 2947x1 1-6 indexes
pthTr_x <- "train/X_train.txt" # 7352x561 values (measurements?)
pthTr_y <- "train/y_train.txt" # 7352x1 1-6 indexes
pthFt <- "features.txt" # 561x2 names of the measurements (variables)

pthBase <- "./UCI HAR Dataset/"
 
dTsSbj <- read.table(paste0(pthBase, pthTs_subj))
dTrSbj <- read.table(paste0(pthBase, pthTr_subj))
dTsX <- read.table(paste0(pthBase, pthTs_x))
dTsY <- read.table(paste0(pthBase, pthTs_y))
dTrX <- read.table(paste0(pthBase, pthTr_x))
dTrY <- read.table(paste0(pthBase, pthTr_y))
dFt <- read.table(paste0(pthBase, pthFt))

# step 1, merging data sets:
dwTr<-cbind(dTrSbj, dTrY, dTrX)
dwTs<-cbind(dTsSbj, dTsY, dTsX)
dbig<-rbind(dwTr, dwTs)

# delete some big objects for optimize computer memory:
rm(dTsSbj, dTrSbj, dTsX, dTsY, dTrX, dTrY, dwTr, dwTs)

#step 2, subset mean and standart deviation columns:
maskMean<-grepl("-mean|-std", dFt[,2])
maskMean <- c(c(TRUE, TRUE), maskMean)
dmean<-dbig[,maskMean]

# step 3, descriptive activity names:
nmAct <- c("Walking", "Walking Upstairs", 
  "Walking Downstairs", "Sitting", "Standing", "Laying")
dmean[,2] <- factor(dmean[,2], labels = nmAct)
dmean[,1] <- factor(dmean[,1], labels = c(1:30))

# step 4, descriptive variable names:
nm <- c(c("subject", "activity"), dFt[,2])
nm<- nm[maskMean]
# "BodyBody"can by replaced to "Body"
nm<-gsub("BodyBody", "Body", nm)

nm<-gsub("^f", "freq", nm)
nm<-gsub("^t", "time", nm)
nm<-gsub("Acc", "Acceleration", nm)
nm<-gsub("Mag", "Magnitude", nm)
nm<-gsub("-mean\\(\\)", "Mean", nm)
nm<-gsub("meanFreq", "MeanFreq", nm)
nm<-gsub("-std\\(\\)", "Std", nm)
nm<-gsub("-", "", nm)
nm<-gsub("\\(\\)", "", nm)

names(dmean)<-nm

# step 5, generate tidy data set
dty<-aggregate(dmean[3:length(dmean)], by=list(subject=dmean$subject, 
          activity=dmean$activity), FUN=mean)
library(dplyr)
dty<-arrange(dty, dty$subject)

dty

# code for writing to file:
# write.table(dty, "tidy_data_set.txt", row.name=FALSE)
# code for reading tidy data set file:
# dd<-read.table("tidy_data_set.txt", header=TRUE)
