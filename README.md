#README

The purpose of the "run_analysis.R" script is to download, merge, subset, and clean data obtained from accelerometers present in the Samsung Galaxy S smartphone. This script was written to be run on a Windows 7 platform using R 3.0.1 or higher.  Note that the home.path variable should be set to your own home directory within which you would like to download the raw data and create the tidy datasets.

A description of the experiment from which this data was collected is at:  
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
	
The raw data, along with details of the experiment is publicly available at:  
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The function of this R script is to take the raw dataset, which is split up into training and testing sets, merge the datasets with informative subject id and activity variables, and create the following two new tidy datasets in tab delimited format:    
	1) data1 - merged dataset containing only the subject id, activity name, mean and standard deviation of the features  
	2) data2 - mean measures for each feature from data1 within each level of subject id and activity. These summarized measurements are appended with "-summarized".  
	
I assume that any featurename containing "mean" or "std" in the original dataset corresponds to a mean or standard deviation.  