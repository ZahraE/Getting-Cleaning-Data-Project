
## Step 1: Rading and merging train and test data.

library(data.table)

Raw_xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")  # Reading training data
Raw_xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")     # Reading testing data 
Raw_x<-rbind(Raw_xtrain,Raw_xtest)                             # Merging training & testing data together 



## Step 2: Extracting mean and standard deviation for each measurement.

fea<-read.table("./UCI HAR Dataset/features.txt")              # Reading feature data
colN=as.character(gsub(",","",fea$V2))                         # Converting feature data's second column into character   
colnames(Raw_x)=colN                                           # Assigning feature data's second culomn to column names        
MS=names(Raw_x[grep("mean()",names(Raw_x))])                   # Extracting column names which contain the word "mean" and assign them to the vector "MS" which contains both mean measurments and meanFreq measurments.  
ms=names(Raw_x[grep("meanFreq",names(Raw_x))])                 # Extracting column names which contain the word "meanFreq" and assign them to the vector "ms" 
Name_MS<-setdiff(MS,ms)                                        # Removing column names containing "meanFreq" ("ms" vector) from the vector "MS' (since we just need mean measurments) and assign it to the vector "Name_MS". 
std=names(Raw_x[grep("std()",names(Raw_x))])                   # Extracting column names which contain the word "std" and assign them to the vector "std" which contains standard deviation measurements 
Names=cbind(Name_MS,std)                                       # Binding Name_MS & std vectors to get all needed column names and assign them to the vector Names
colnames(Names)=NULL                                           # Removing all column names of vactor "Names"
Names=as.character(Names)                                      # Converting vector "Names" to character
Raw=Raw_x[Names]                                               # Getting mean and standard deviation columns for each measurement 



## Step 3: Naming the activities in the data set using descriptive activity names.

Test_indx<-read.table("./UCI HAR Dataset/test/y_test.txt")     # Reading testing labels
Train_indx<-read.table("./UCI HAR Dataset/train/y_train.txt")  # Reading training labels
indx=rbind(Train_indx,Test_indx)                               # Creating "indx" vector containing both testing and training labels
colnames(indx)=NULL                                            # Removing all column names of vactor "indx"
Raw$actName=as.factor(as.matrix(indx))                         # Adding "indx" factor vector as a column to "Raw" dataset which we obtained at the end of previous step.
names(Raw$actName)="actName"                                   # Assigning "actName" as the name of the column we just added to our dataset.        
Raw$actName=gsub("1","WALKING",Raw$actName)                    # Replacing activity name "WALKING" (which corresponds to label "1") with all 1s in column actName.  
Raw$actName=gsub("2","WALKING_UPSTAIRS",Raw$actName)           # Replacing activity name "WALKING_UPSTAIRS" (which corresponds to label "2") with all 2s in column actName.
Raw$actName=gsub("3","WALKING_DOWNSTAIRS",Raw$actName)         # Replacing activity name "WALKING_DOWNSTAIRS" (which corresponds to label "3") with all 3s in column actName.
Raw$actName=gsub("4","SITTING",Raw$actName)                    # Replacing activity name "SITTING" (which corresponds to label "4") with all 4s in column actName.
Raw$actName=gsub("5","STANDING",Raw$actName)                   # Replacing activity name "STANDING" (which corresponds to label "5") with all 5s in column actName.
Raw$actName=gsub("6","LAYING",Raw$actName)                     # Replacing activity name "LAYING" (which corresponds to label "6") with all 6s in column actName.
Raw_actName=Raw[,c("actName",setdiff(names(Raw),"actName"))]   # Moving column actName to the first column of dataset and letting all other columns' places to remain unchanged.
Test_sub<-read.table("./UCI HAR Dataset/test/subject_test.txt")    # Reading testing subject data
Train_sub<-read.table("./UCI HAR Dataset/train/subject_train.txt") # Reading training subject data
sub=rbind(Train_sub,Test_sub)                                  # Creating "sub" vector containing both testing and training subjects
colnames(sub)=NULL                                             # Removing all column names of vactor "sub"
Raw_actName$sub=as.factor(as.matrix(sub))                      # Adding "sub" factor vector as a column to "Raw_actName" dataset.
names(Raw_actName$sub)="sub"                                   # Assigning "sub" as the name of the column we just added to our dataset.
Tidy=Raw_actName[,c("sub",setdiff(names(Raw_actName),"sub"))]  # Moving column "sub" to the first column of dataset and letting all other columns' places to remain unchanged.

## Step 4: Labeling the data set with descriptive variable names

names(Tidy$sub)=NULL                                           # Removing all column names of our dataset.       
Final_colNames=c("subject","activity_name",Names)              # Creating character vector "Final_colNames" to use as column names.
colnames(Tidy)=Final_colNames                                  # Assignenig vector "Final_colNames" to Tidy dataset column names.  

## Step 5: Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr);
TidyMean=aggregate(. ~subject + activity_name, Tidy, mean)         # Measuring the mean of each variable for each activity and each subject.
TidyMean=TidyMean[order(TidyMean$subject,TidyMean$activity_name),] # Sorting the data based on subject labels.



## Creating Text File

write.table(TidyMean, "tidy.txt", row.names=F) 


########################################
## To read the data back into R one should run the following code:

# library(data.table)
# read.table("tidy.txt",header=T,check.names=F)

########################################

