# Read the Activity 
  DataActivityTrain <- read.table(file.path(path_file, "train", "Y_train.txt"), header = FALSE)
  DataActivityTest  <- read.table(file.path(path_file, "test" , "Y_test.txt" ), header = FALSE)
                                                                                
##  Read the Subject 
  DataSubjectTrain <- read.table(file.path(path_file, "train", "subject_train.txt"), header = FALSE)
  DataSubjectTest  <- read.table(file.path(path_file, "test" , "subject_test.txt"), header = FALSE)
                                                                                
#  Read Features 
  DataFeaturesTrain <- read.table(file.path(path_file, "train", "X_train.txt"), header = FALSE)
  DataFeaturesTest  <- read.table(file.path(path_file, "test" , "X_test.txt"), header = FALSE)
 
  ## look at the structure of the variables
  str(DataActivityTrain)
  str(DataActivityTest)
  str(DataSubjectTrain)
  str(DataSubjectTest)  
  str(DataFeaturesTrain)
  str(DataFeaturesTest)
 
#  Concatenate the data tables by rows
  ActivityData <- rbind(DataActivityTrain, DataActivityTest)        
  SubjectData <- rbind(DataSubjectTrain, DataSubjectTest)
  FeaturesData <- rbind(DataFeaturesTrain, DataFeaturesTest)
 
# Set names to variables
  names(ActivityData) <- c("activity")
  names(SubjectData) <- c("subject")
  FeaturesDataNames <- read.table(file.path(path_file, "features.txt"), head=FALSE)
  names(FeaturesData) <- FeaturesDataNames$V2                                    
  FeaturesDataNames
  
# Merge columns 
  CombineData <- cbind(ActivityData, SubjectData)
  CombineAllData <- cbind(FeaturesData, CombineData)  
  CombineAllData
  
#  Subset Name of Features by measurements on the mean and standard deviation
#        i.e taken Names of Features with “mean()” or “std()” 
  SubsetFeaturesDataNames <- FeaturesDataNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesDataNames$V2)]
  SubsetFeaturesDataNames

#  Subset the dataframe Data by selected names of Features 
  SelectedNames <- c(as.character(SubsetFeaturesDataNames), "subject", "activity")
  CombineAllData <- subset(CombineAllData, select = SelectedNames) 
  View(CombineAllData)                                                                    

#  Check the structures of the dataframe Data 
  str(CombineAllData)                                                                    

#  Read descriptive activity names from “activity_labels.txt”
  
  activityLabels <- read.table(file.path(path_file, "activity_labels.txt"), header = FALSE) 
  activityLabels
  head(CombineAllData$activity,30)

  # Check
  names(CombineAllData)
  
# Creates a second,independent tidy data set and output it.
  library(plyr);                                                                
  TidyData2 <- aggregate(. ~subject + activity, CombineAllData, mean)
  TidyData2 <- TidyData2[order(TidyData2$subject, TidyData2$activity),]
  str(TidyData2)
  
# Writing second tidy data set in txt file
  write.table(TidyData2, file = "tidydata.txt", row.name = FALSE)
  
