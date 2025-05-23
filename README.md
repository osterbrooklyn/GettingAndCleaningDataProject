# Getting and Cleaning Data Project

## Project Overview

This project processes the Samsung Human Activity Recognition dataset collected from smartphone accelerometers. The goal is to merge, clean, and summarize the data to produce a tidy dataset containing the average of each measurement for each activity and each subject.

## Files

- `run_analysis.R`: The R script to download, process, and tidy the data.
- `tidy_data.txt`: The final tidy dataset output by the script.
- `CodeBook.md`: Documentation describing the variables and transformations applied.

## How to run

1. Make sure the Samsung data folder (`UCI HAR Dataset`) is in your working directory, or let the script download and unzip it.
2. Run the R script in R or RStudio:

```r
source("run_analysis.R")