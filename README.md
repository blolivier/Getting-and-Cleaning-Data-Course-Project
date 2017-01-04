# Getting-and-Cleaning-Data-Course-Project
This repository contains the Coursera assignment of the Getting and Cleaning data

## Introduction
The aim was to download raw data and clean it to obtain a summarised dataset. The approach followed was to limit
manual varaible naming, but instead leveraging of the existing files in the downloaded folder. SQL was mainly used
for combining data.

## Code logic
1. Data was downloaded and the relevant datasets was imported into R
2. The subject numbers and activity numbers was included and finally the train and test data were merged
3. Variable names with "mean" and "standard deviation" were selected in lookup sets and were then used
   to obtain only the relevant variable names
4. Variable names were changed by replacing special characters with more appropriate logic
5. A summary view on the mean of each variable per subject per activity was obtained

## Final remarks
The script obtain a final clean set. Several approaches could give this answer. It might be more effective to 
"melt" the data earlier in the program, but the current script does the job well.
