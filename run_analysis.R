
# This program will address the 5 points below as stated in the assignment brief:


# You should create one R script called run_analysis.R that does the following:
# 01. Merges the training and the test sets to create one data set.
# 02. Extracts only the measurements on the mean and standard deviation for each measurement.
# 03. Uses descriptive activity names to name the activities in the data set
# 04. Appropriately labels the data set with descriptive variable names.
# 05. From the data set in step 4, creates a second, independent tidy data set with the average
#     of each variable for each activity and each subject.


library(magrittr)

# Create a path to the downloaded Samsung data
wd_path1 = "C:/Users/Nardus/Documents/coursera/Data Science/Course 3 - Data Cleaning/Week 4/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset"

# Create a path for the final export
wd_path2 = "C:/Users/Nardus/Documents/coursera/Data Science/Course 3 - Data Cleaning/Week 4"

# Set the work directory to the downloaded data
setwd(wd_path1)

# Import labels
labels_vars = read.table("features.txt")
labels_activity = read.table("activity_labels.txt")

# Import train data
raw_train_x = read.table("./train/X_train.txt")
raw_act_train = read.table("./train/y_train.txt")
raw_idn_train = read.table("./train/subject_train.txt")
data.table::setnames(raw_act_train, "V1", "activity_cd")
data.table::setnames(raw_idn_train, "V1", "volunteer_id")
train_final = cbind(raw_idn_train, raw_act_train, raw_train_x)

# Import test data
raw_test_x = read.table("./test/X_test.txt")
raw_act_test = read.table("./test/y_test.txt")
raw_idn_test = read.table("./test/subject_test.txt")
data.table::setnames(raw_act_test, "V1", "activity_cd")
data.table::setnames(raw_idn_test, "V1", "volunteer_id")
test_final = cbind(raw_idn_test, raw_act_test, raw_test_x)

# Align label keys with default variable names and select specific variable names
labels_select = sqldf::sqldf("
    select *
        ,'V' || v1 as var_cd
    from labels_vars
    where v2 like '%mean%'
        or v2 like '%std%'
")

# Merge train and test data (requirement 1)
combined_set = rbind(cbind(train_final, set_group = "Train")
                ,cbind(test_final, set_group = "Test")
                )

# Only select the measurements on the mean and standard deviation (requirement 2)
combined_set2 = combined_set[,c("volunteer_id","activity_cd",labels_select$var_cd)]

# Incorporate the activity names in the main dataset (requirement 3)
combined_set3 = sqldf::sqldf("
    select 
        a.*
        ,b.V2 as activity_desc

    from combined_set2 a
    
        left join labels_activity b
            on b.V1 = a.activity_cd
    
    order by a.volunteer_id
        ,a.activity_cd
")

# Rearange the variable positions
combined_set3 = combined_set3[,c(1,2,ncol(combined_set3),(4:ncol(combined_set3)-1))]

# Obtain original variable labels
final_vars = as.data.frame(names(combined_set3))
final_vars$var_name = final_vars[,1]
final_vars = dplyr::select(final_vars, var_name)

new_var_lookup = sqldf::sqldf("
    select a.var_name
        ,case
            when b.var_cd = a.var_name then b.V2
            else a.var_name
        end as new_var_desc

    from final_vars a
        left join labels_select b
            on b.var_cd = a.var_name
")

# Remove special characters from variable names and replace with other codes
new_var_lookup$new_var_name = gsub("()", "", new_var_lookup$new_var_desc, fixed = TRUE)
new_var_lookup$new_var_name = gsub("-", "_", new_var_lookup$new_var_name, fixed = TRUE)
new_var_lookup$new_var_name = gsub("(", "_0_", new_var_lookup$new_var_name, fixed = TRUE)
new_var_lookup$new_var_name = gsub(")", "_0_", new_var_lookup$new_var_name, fixed = TRUE)
new_var_lookup$new_var_name = gsub(",", "_", new_var_lookup$new_var_name, fixed = TRUE)

# Replace existing variable names with the new ones (requirement 4)
combined_set4 = setNames(combined_set3, new_var_lookup$new_var_name)

# Summarised set over subject and activity (requirement 5)
summary_set = combined_set4 %>%
    data.table::melt(combined_set4
                     ,id.vars = names(combined_set4)[1:3]
                     ,measure.vars = names(combined_set4)[4:length(names(combined_set4))]
                     ,variable.name = "measurement_variable"
    ) %>%
    dplyr::group_by(volunteer_id, activity_cd, activity_desc, measurement_variable) %>%
    dplyr::summarize(measurement_mean = mean(value))

# Only keep the final dataset
rm(list=setdiff(ls(), "summary_set"))

# Explore the final set
str(summary_set)

# Set the work directory to the export folder
setwd(wd_path2)

# Export the set
write.table(summary_set
            ,"Tidy data summary.txt"
            ,row.name = FALSE
            )