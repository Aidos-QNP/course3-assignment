# sorry for my English!
# My Github: https://github.com/Aidos-QNP/course3-assignment

# exploring data sets with read.table(), 
pthTs_subj <- "test/subject_test.txt" # 2947x1 2-24 indexes
pthTr_subj <- "train/subject_train.txt" # 7352x1 1-30 indexes
pthTs_x <- "test/X_test.txt" # 2947x561 values (measurements?)
pthTs_y <- "test/y_test.txt" # 2947x1 1-6 indexes
pthTr_x <- "train/X_train.txt" # 7352x561 values (measurements?)
pthTr_y <- "train/y_train.txt" # 7352x1 1-6 indexes
pthFt <- "features.txt" # 561x2 names of the measurements (variables)

pthBase <- "./data/UCI HAR Dataset/"

dTsSbj <- read.table(paste0(pthBase, pthTs_subj))
dTrSbj <- read.table(paste0(pthBase, pthTr_subj))
dTsX <- read.table(paste0(pthBase, pthTs_x))
dTsY <- read.table(paste0(pthBase, pthTs_y))
dTrX <- read.table(paste0(pthBase, pthTr_x))
dTrY <- read.table(paste0(pthBase, pthTr_y))
dFt <-  read.table(paste0(pthBase, pthFt))
# after reading Read me file and analyzing data sets with 
# as_tibble (tibble library), dim() and summary() I wrote
# result as comments in 5-11 lines: dimension and form of the data

# I decide to organize variables (columns) so: "subject", 
# "activity" and 561 features from features.txt

# step 1, merging data sets:
# first, all train columns
dwTr<-cbind(dTrSbj, dTrY, dTrX)
# then all test columns
dwTs<-cbind(dTsSbj, dTsY, dTsX)
# then merge this two data sets by rows
dbig<-rbind(dwTr, dwTs)

# delete some big objects for optimize computer memory:
rm(dTsSbj, dTrSbj, dTsX, dTsY, dTrX, dTrY, dwTr, dwTs)

#step 2, subset mean and standart deviation columns:
maskMean<-grepl("-mean|-std", dFt[,2])
# we need to leave first two column, so lets include to mask:
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
# some replacements based on lecture "04-01 Editing 
# Text Variables" last slide
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

# step 5
library(reshape2)
dml<-melt(dmean, id=c("subject", "activity"), 
          measure.vars = names(dmean[, 3:81]))
names(dml)[3]<-"measurement"

library(dplyr)
dty<- dml %>% group_by(subject, activity, measurement) %>%
    mutate(value=mean(value)) %>%
    unique() %>%
    arrange(subject, .by_group = TRUE)
names(dty)[4]<-"mean"

# write to file
write.table(dty, "tidy_data_set.txt")
# code for reading tidy data set file:
# dd<-read.table("tidy_data_set.txt")
