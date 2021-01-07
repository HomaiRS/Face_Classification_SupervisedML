### MY Eigenface "Adaboost":
graphics.off(); par("mar"); par(mar=c(1,1,1,1));
matlabTrain <- read.csv("MatTrain_10.csv")
matlabTest <- read.csv("MatTest_10.csv")
Len=dim(matlabTrain)

for (i in 2:Len[2]) {
  # print(colnames(matlabTrain)[i])
  colnames(matlabTrain)[i] <- paste0("X.",i-1)
  colnames(matlabTest)[i] <- paste0("X.",i-1)
}
colnames(matlabTrain)[1] <- "Y"
colnames(matlabTest)[1] <- "Y"

y <- matlabTrain$Y
x <- data.frame(matlabTrain[,2:Len[2]])

xtst <- data.frame(matlabTest[,2:Len[2]])
ytst <- matlabTest$Y
#-------------------------------------------------------- Adaboost
library(gbm)
library(caret)
MyBoost = gbm(y ~ . ,data = x,distribution = "gaussian",n.trees = 10000, shrinkage = 0.01, interaction.depth = 4)
MyBoost
summary(MyBoost) #Summary gives a table of Variable Importance and a plot of Variable Importance

n.trees = seq(from=100 ,to=10000, by=100)
yhatGBM_Trn <- predict(MyBoost, x, n.trees = n.trees)
MSEGBM_Trn <- with(x, apply( (yhatGBM_Trn-y)^2,2,mean))
# MSEGBM_Trn
TrnMinGBM_nTree <- which.min(MSEGBM_Trn)
MSEGBM_Trn[TrnMinGBM_nTree]

n.trees = seq(from=100 ,to=10000, by=100) #no of trees-a vector of 100 values 
#Generating a Prediction matrix for each Tree
yhatGBM_Tst<-predict(MyBoost,xtst, n.trees = n.trees)
dim(yhatGBM_Tst) #dimentions of the Prediction Matrix

#Calculating The Mean squared Test Error
MSEGBM_Tst<-with(xtst,apply( (yhatGBM_Tst-ytst)^2,2,mean))
# MSEGBM_Tst
MinGBM_nTree <- which.min(MSEGBM_Tst) #contains the Mean squared test error for each of the 100 trees averaged
MSEGBM_Tst[MinGBM_nTree]

Optimal_yhatGBM_Tst <- yhatGBM_Tst[,MinGBM_nTree]
Optimal_yhatGBM_Tst = ifelse(Optimal_yhatGBM_Tst < .5, "0", "1")
Optimal_yhatGBM_Tst = as.numeric(Optimal_yhatGBM_Tst)

tab6 <- table(pred = Optimal_yhatGBM_Tst, true=ytst)
cm6 <-confusionMatrix(tab6) 
cm6$table 
fourfoldplot(cm6$table,color = c("#B22222", "#DC143C"))
GBM_Misclassifieds = cm6$table[1,2]+cm6$table[2,1]
GBM_Misclassifieds


#Plotting the test error vs number of trees
plot(n.trees , MSEGBM_Tst , pch=19,col="dark blue",xlab="Number of Trees",ylab="Out of sample performance (MSE)", main = "Perfomance of Boosting on Test Set")

#adding the RandomForests Minimum Error line trained on same data and similar parameters
abline(h = min(MSEGBM_Tst),col="red") #test.err is the test error of a Random forest fitted on same data
legend("topright",c("Minimum Test error Line for Random Forests"),col="red",lty=1,lwd=1.5, cex=1)


