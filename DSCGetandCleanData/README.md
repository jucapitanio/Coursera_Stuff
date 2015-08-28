###Project for Getting and Cleaning Data from Coursera Data Science 

This repo refers to the Coursera MOOC Getting and Cleaning Data. It contains the files and analysis for the Course project.

This project was based on the Human Activity Recognition Using Smartphones Data Set from the UCI machine learning repository.[1]
More information on the Data Set can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for this analysis was downloaded on Sun May 25 00:29:03 2014 from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repo contains a file, CodeBook.md, detailing all the variables present in the data set as well as a summary of the choices made during the analysis script.
The analysis required for this project can be executed from the scrip file run_analysis.R.

This script will perform the following steps:

1. Check if data file must be unzipped and unzip if necessary.
2. Reading data into R and merging training and test datasets.
3. Merging subject and activity to the 561 features data.
4. Changing column names to appropriate feature name.
5. Extracting only mean and standard deviation for each measurement.
6. Appropriatelly labeling activity names.
7. Creating a new data set with the average of each variable for each activity and each subject.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
