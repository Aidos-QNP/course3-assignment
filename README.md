Getting and Cleaning Data course assignment
========================

*[ Sorry for my English! ]*

## run_analysis.R script

Input raw data set is "Human Activity Recognition Using Smartphones Dataset" (Version 1.0) (Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto).

run_analysis.R script does this:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
And then generates a tidy data text file that meets the principles of tidy data:
1. Each variable you measure should be in one column
2. Each different observation of that variable should be in a different row
3. There should be one table for each "kind" of variable
Every step was analyzed with as_tibble() (tibble library), head(), tail(), summary(), dim() functions.

### Step 0. Analyze

Exploring data sets with read.table(). After reading Read me file and analyzing data sets I wrote results as comments at the end of 5-11 lines of script: dimension and type of the data for each raw file. Based on the principles of tidy data there is 5 variables: subject (person id), activity, name of measurement (feature), measurement sample number and value of measurement. Measurement sample number will be collapsed after calculating averages (in step 5), so we can ignore it.
We can organize columns in this order: "subject", "activity" and 561 features from features.txt

### Step 1. Merging data sets

Data set was merged in this order:
1. all train data sets as columns
2. all test data sets as columns
3. merge this two data sets as rows

### Step 2. Extracts only the measurements on the mean and standard deviation

We need mask based on regular expression. grepl() function can handle this.
Also first two columns (subject and activity) should be included to mask.

### Step 3. Descriptive activity names

This names is descriptive: "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"

### Step 4. Descriptive variable names

Some replacements based on lecture "04-01 Editing Text Variables".
1. All lower cases when possible
2. Descriptive
3. Not duplicated
4. Not have underscores or dots or white spaces

### Step 5. Reshape raw data set and generate tidy data set

Raw data set should be melted to meet the the principles of tidy data.
Feature column names was converted to column and value of features converted to value column by melt() function (dplyr library). So there are 4 variables and 4 columns. 

Next - the average of each variable for each activity and each subject. We need to mean each group, so first we need to create group by 3 variables (all except "value") by group_by() function. Then calculate mean by groups with replacing "value" column by mutate() function. Then unique() - to delete same rows, arrange() to sort, then name "value" column to "mean". Result is tidy data set.
Last, write tidy data set to file.