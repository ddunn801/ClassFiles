ClassFiles
==========
The course project script is contained in one file called run_analysis.R and is in this same directory. 

This R script uses the reshape package.
The test and train data and label files are read in and assembled into data frame.
The feature labels are read in and a list is identified of which relate to either a mean or a standard deviation.
The existing columns are renamed to the feature labels, then the data frame is subset to the mean/sd list.
The activities are labeled to descriptive terms.
Subject ids are added to the data frame.
The data frame is then summarized to show the averages of each metric for each combination of Activity and Subject.
