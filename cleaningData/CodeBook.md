# CodeBook - Cleaning Data


# Introduction

The script `run_analysis.R` execute 5 steps with full description on what steps are trying to achieve through detailed comments.

* All data is merged using `dplyr` package bind_rows and bind_columns instead of `rbind()` and `cbind()` .  
* Columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt` .
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with acronym names are corrected through `gsub` function.
* A new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `tinyData.txt`, and uploaded to this repository.

# Variables

* `training.x`, `training.y`, `test.x`, `test.y`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `merged.x`, `merged.y` and `merged.subject` merge the previous datasets to further analysis.
* A similar approach is taken with activity names through the `activities` variable.
* `completeDAta` merges `merged.x`, `merged.y` and `merged.subject` in a big dataset.
* Finally, `tinyData` contains the relevant averages which will be later stored in a `.txt` file.

