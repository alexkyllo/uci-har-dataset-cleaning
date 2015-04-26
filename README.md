# uci-har-dataset-cleaning
R script for cleaning the UCI HAR dataset (Samsung Smartphone activity tracking data)
For Coursera Getting and Cleaning Data course: https://class.coursera.org/getdata-013/

The script reads in the training and test data into data frames, concatenates them together using rbind, applies column labels describing the variables, and adds columns describing the observation rows (subject id and activity type). It selects only the means and standard deviations of all variables, and then summarizes the observations by the mean of each variable, grouping by subject id / activity type combination.