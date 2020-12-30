#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
#download.file(fileUrl,destfile="./data/fgdp.csv")

# exploring data sets with read.table(), 

pthTs_subj<-"test/subject_test.txt" # 2947x1 2-24 indexes
pthTr_subj<-"train/subject_train.txt" # 7352x1 1-30 indexes
pthTs_x<-"test/X_test.txt" # 2947x561 measurements
pthTs_y<-"test/y_test.txt" # 2947x1 1-6 indexes
pthTr_x<-"train/X_train.txt" # 7352x561 measurements
pthTr_y<-"train/y_train.txt" # 7352x1 1-6 indexes
pthFt<-"features.txt" # 561x2 names of the measurements (variables)

pthBase<-"./data/UCI HAR Dataset/"

dTsSbj <- read.table(paste0(pthBase, pthTs_subj))
dTrSbj <- read.table(paste0(pthBase, pthTr_subj))
dTsX<- read.table(paste0(pthBase, pthTs_x))
dTsY<- read.table(paste0(pthBase, pthTs_y))
dTrX <- read.table(paste0(pthBase, pthTr_x))
dTrY <- read.table(paste0(pthBase, pthTr_y))
dFt<-  read.table(paste0(pthBase, pthFt))
# after reading Read me file and analyzing data sets with 
# as_tibble (tibble library), # dim() and summary() I wrote
# result as comments in 6-11 lines: dimension and form of the data

# step 1, merging data sets 

dim(dFt)
head(pthTs_y)
summary(dTsY)
install.packages("tibble")
library(tibble)
d1<-as_tibble(d1)

d1
head(d1)
summary(d1)
dim(d1)
View(d1)
d1<-as.numeric(d1)
dim(d1)
d1[[1]]
class(d1)
typeof(d1)

d2<-as.data.frame(d1[[1]])
length(d1[2, 1])
head(d2)
length(d2)
dim(d2)
typeof(d2)
d2<-as.table(d2)
names(d1)
length(names(d1))
d1

substr(names(d1), 1, 100)
tt<-d1[2, 1][[1]]
tt
tt2<-strsplit(tt, " ")
length(tt2)
