The file run_analysis.R produces two tidy data frames from the
Human Activity Recognition Using Smartphones data set.


To run the code:

1. Download data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unzip the downloaded file above.

3. Open run_analysis.R.  Make sure the setwd line references the directory containing the saved and unzipped raw data.  There should be 'test' and 'train' subdirectories and files 'activity_labels.txt' and 'features.txt' in the main directory.

4. Run the script in run_analysis.R.  It will create two tidy data frames:

i. all_mean_and_std_data (contains all measurements for each mean() and std() variable in the raw data)
Steps taken to make this data tidy:  
-All data stored in a single table  
-Each column contains a single variable  
-Variable names are descriptive  
-The activity variable contains labels in place of numeric codes  


ii. subject_activity_avgs (contains averages of each variable in the first data set, grouped by subject and activity)  
-Note that the column names are the same as the first data table.  It is to be understood that the represent means (averages) of each variable over each subject & activity combination.
