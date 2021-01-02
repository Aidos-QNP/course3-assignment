Code book - Tidy data set
======================

# Summary

Dimension of table: 14220 rows and 4 columns.

## head()
    subject activity               measurement        mean
    1   Walking timeBodyAccelerationMeanX  0.27733076
    1   Walking timeBodyAccelerationMeanY -0.01738382
    1   Walking timeBodyAccelerationMeanZ -0.11114810
    
## summary()
    subject       activity         measurement             mean         
     Min.   : 1.0   Length:14220       Length:14220       Min.   :-0.99767  
     1st Qu.: 8.0   Class :character   Class :character   1st Qu.:-0.95242  
     Median :15.5   Mode  :character   Mode  :character   Median :-0.34232  
     Mean   :15.5                                         Mean   :-0.41241  
     3rd Qu.:23.0                                         3rd Qu.:-0.03654  
     Max.   :30.0                                         Max.   : 0.97451

# Variables

## subject
    An identifier of the subject who carried out the experiment.
    Group of 30 volunteers within an age bracket of 19-48 years.
    
    Integer values in 1:30 range.

## activity
    Six activities, subject  performed:
    1. "Walking",
    2. "Walking Upstairs", 
    3. "Walking Downstairs",
    4. "Sitting",
    5. "Standing",
    6. "Laying"
    
    6 character values.

## measurement
    Names of features, measurements of time and frequency domains.
    *timeBodyAccelerationMeanX
    *timeBodyAccelerationMeanY
    *etc.
    
    79 character values.
    
## mean
    average (mean) of the measurements for each activity and each subject.
    
    14220 numeric values.