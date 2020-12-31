#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
#download.file(fileUrl,destfile="./data/fgdp.csv")

# exploring data sets with read.table(), 

pthTs_subj <- "test/subject_test.txt" # 2947x1 2-24 indexes
pthTr_subj <- "train/subject_train.txt" # 7352x1 1-30 indexes
pthTs_x <- "test/X_test.txt" # 2947x561 measurements
pthTs_y <- "test/y_test.txt" # 2947x1 1-6 indexes
pthTr_x <- "train/X_train.txt" # 7352x561 measurements
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
# as_tibble (tibble library), # dim() and summary() I wrote
# result as comments in 6-11 lines: dimension and form of the data

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

# to assign variables names first we need modify feature name set
# by adding two new variable names
names(dbig) <- c(c("subject", "activity"), dFt[,2])

#step 2, subset mean and standart deviation columns:
sbsMask<-grepl("-mean|-std", names(dbig))
# we need to leave first two column, so lets include to mask:
sbsMask[1:2] <- c(TRUE, TRUE)
dmean<-dbig[,sbsMask]

# step 3, descriptive activity names:
nmAct <- c("Walking", "Walking Upstairs", 
  "Walking Downstairs", "Sitting", "Standing", "Laying")

dmean$activity <- as.factor(dmean$activity)
levels(dmean$activity)<-nmAct


head(fAct)
head(dmean$activity)
?as.factor

summary(dmean[,2])
install.packages("tibble")
library(tibble)
dmean<-as_tibble(dmean)

# some tests:
dmean
dbig[4, 1:10]
as_tibble(dbig)

tt<-grep("mean", names(dbig), value=TRUE, ignore.case = TRUE) 
length(tt)
tt
grep("-mean|-std", names(dbig), value=TRUE)
View(dbig[1:4, tt])
tr<-grep("fBodyAcc-bandsEnergy()", dFt[,2], value = TRUE)
length(tr)
tr
