train<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//train//X_train.txt")
test<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//test//X_test.txt")

ytrain<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//train//y_train.txt")
ytest<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//test//y_test.txt")

subject_train<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//train//subject_train.txt")
subject_test<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//test//subject_test.txt")

ytest<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//test//y_test.txt")

feat<-read.table("E://Documentos//6. Cursos//4. Cursos por Video//Coursera_DataSpecialization//03GettingData//Proyecto//data//UCI HAR Dataset//features.txt")


train$subject<-subject_train[,1]
test$subject<-subject_test[,1]

train$activity<-ytrain[,1]
test$activity<-ytest[,1]

#1 Merges the training and the test sets to create one data set.
        all<-merge(train,test,all=TRUE)

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
        x_means<-sapply(all,sum)
        x_sd<-sapply(all,sd)
        
#3 Uses descriptive activity names to name the activities in the data set
        all$activity<-as.factor(all$activity)
        levels(all$activity)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"
                                ,"SITTING","STANDING","LAYING")
 
#4 Appropriately labels the data set with descriptive variable names. 
        names1<-as.character(feat[,2])
        names1<-str_replace_all(names1, "[,]", "_")
        names1<-str_replace_all(names1, "[-]", "_")
        names1<-str_replace_all(names1, "[()]", "")
        names(all)<-c(names1,"subject","activity")

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
         
        attach(all)
        final<-aggregate(.~subject+activity,data=all,mean)
        final$subject<-NA
        final$activity<-NA
        names(final)<-str_replace_all(names(final), "Group.1", "Subject")
        names(final)<-str_replace_all(names(final), "Group.2", "Activity")

        write.table(final, file="tidydata.txt", row.names=FALSE)
        write.table(names(final), file="otro.txt", row.names=FALSE)
