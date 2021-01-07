TrainSetProp = read.csv("faceDRDSCombo.csv", header = TRUE, sep ="_"); 
# read.csv("Orgtrain_list.csv", header = TRUE, sep ="_"); 

library(data.table)
colnames(TrainSetProp) <- c("photoID","Sex","Age","Race","Face","Prop")
TrainSetProp <- data.table(TrainSetProp)
TrainSetProp$label = 1

TrainSetProp <- TrainSetProp[!grepl("missing descriptor", TrainSetProp$Sex),]
# TrainSetProp <- TrainSetProp[!grepl("face funny", TrainSetProp$Face),]

# Give string delimitor:
delim = "adult";
adultData<-TrainSetProp[Age %like% delim]
# adultData <- TrainSetProp
adultData$label<-factor(adultData$Sex,labels =c(0,1))
adultIdLabel <- data.frame(adultData$label,adultData$photoID)

## read images from file and to vector, add to data set
write.table(adultIdLabel, file = "AdultphotoIDLabel.csv",row.names = FALSE,col.names = FALSE,sep=",")
