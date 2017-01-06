# Code Book of final data

## Data summary
The "Tidy data summary" text file has 5 variables and 15480 observations. The "activity_desc" field contains the measurements for each subject in the study for each activity.

## Variables
**1. volunteer_id:** 
This is the unique subject number who was part of the study. The total unique subjects is 30.

**2. activity_cd:** 
This is the activity code. There are 6 activities.

**3. activity_desc:** 
Activity description. This gives the detail of the activity.

**4. measurement_variable:** 
Measurement of each activity. These are the measurements taken from the study. This contains 86 unique measurements. Explanation of these variables will be given in the next section.

**5. measurement_mean:** 
The mean of all the observations for each variable. This is summarised by points 1 and 2.

## Measurements explained
Note that most of the below was copied from the original source's features document.

###Feature Selection 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern (the '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions):
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
* mean(): Mean value
* std(): Standard deviation
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

### Final comments on measurements
In the data variable set brackets and dashes were replaced by underscores. To indicate outer brackets for "angle()" the "underscore-zero-underscore" string was used.

***Citation:*** 
_Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013._
