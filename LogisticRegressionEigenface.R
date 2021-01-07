### MY Eigenface "Logistic regression":
matlabTrain <- read.csv("MatTrain_700.csv")
matlabTest <- read.csv("MatTest_700.csv")
Len=dim(matlabTrain)

for (i in 2:Len[2]) {
  # print(colnames(matlabTrain)[i])
  colnames(matlabTrain)[i] <- paste0("X.",i-1)
  colnames(matlabTest)[i] <- paste0("X.",i-1)
}

colnames(matlabTrain)[1] <- "Y"
colnames(matlabTest)[1] <- "Y"

y <- matlabTrain$Y
x <- as.matrix(matlabTrain[,2:Len[2]])

ytst <- matlabTest$Y
#-------------------------------------------------------- Logistic regression 
#--------------------------------------------------------
#--------------------------------------------------------
library(ggplot2)
library(caret)
myLogit <- glm(y~., data = matlabTrain[,2:Len[2]],family = "binomial")
summary(myLogit)
#########---------------------Logistic regression train error
yhatLogit_Trn = predict(myLogit, matlabTrain[,2:Len[2]], type="response")
yhatLogit_Trn = ifelse(yhatLogit_Trn < .5, "0", "1")
yhatLogit_Trn = as.numeric(yhatLogit_Trn)

MSELogit_Trn = mean((yhatLogit_Trn-y)^2)
print(MSELogit_Trn)

tab1 <- table(pred = yhatLogit_Trn, true=y); 
cm1<-confusionMatrix(tab1) #Construct the confusion matrix
#########---------------------Logistic regression test error
yhatLogit_Tst = predict(myLogit, matlabTest[,2:Len[2]], type="response")
yhatLogit_Tst = ifelse(yhatLogit_Tst < .5, "0", "1")
yhatLogit_Tst = as.numeric(yhatLogit_Tst)

MSELogit_Tst = mean((yhatLogit_Tst-ytst)^2)
print(MSELogit_Tst)

tab2 <- table(pred = yhatLogit_Tst, true=ytst); 
cm2<-confusionMatrix(tab2) #Construct the confusion matrix
cm2$table
fourfoldplot(cm2$table, color = c("#191970", "#7B68EE")) #Here is the Fancy plot
Logit_Misclassifieds = cm2$table[1,2]+cm2$table[2,1]
Logit_Misclassifieds

