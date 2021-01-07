### MY Eigenface "LASSO regression":
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
x <- as.matrix(matlabTrain[,2:Len[2]])

ytst <- matlabTest$Y

xtst <- data.frame(matlabTest[,2:Len[2]])
xtrn <- data.frame(matlabTrain[,2:Len[2]])
#-------------------------------------------------------- LASSO
#--------------------------------------------------------
#--------------------------------------------------------
library(Matrix)
library(foreach)
library(glmnet)
library(ggplot2)
library(lattice)
library(caret)

lambdas <- 100^seq(3, -2, by = -.1)
MyLasso <- glmnet(x, y, alpha = 0, lambda = lambdas)
summary(MyLasso)

#We can automatically find a value for lambda that is optimal by using cv.glmnet() as follows:
cv_MyLasso <- cv.glmnet(x, y, alpha = 0, lambda = lambdas)
#cv.glmnet() uses cross-validation to work out how well each model generalises, 
#which we can visualise as:
# par(mfrow=c(2,1))
plot(cv_MyLasso)
opt_lambda <- cv_MyLasso$lambda.min
opt_lambda
u=0
LassoCoef = coef(cv_MyLasso) 
for (i in 1:length(LassoCoef)){
  if (LassoCoef[i]>1e-05){
    u=u+1;
  }
}
u
x <- as.matrix(matlabTrain[,2:Len[2]]); xtst <- as.matrix(matlabTest[,2:Len[2]])
y <- matlabTrain$Y; ytst <- matlabTest$Y; 

yhatLasso_Trn <- predict(MyLasso, s = opt_lambda, newx = x); 
yhatLasso_Trn = ifelse(yhatLasso_Trn < .5, "0", "1")
yhatLasso_Trn = as.numeric(yhatLasso_Trn)
MSELasso_Trn = mean((yhatLasso_Trn-y)^2)
print(MSELasso_Trn)

yhatLasso_Tst <- predict(MyLasso, s = opt_lambda, newx = xtst); 
yhatLasso_Tst = ifelse(yhatLasso_Tst < .5, "0", "1")
yhatLasso_Tst = as.numeric(yhatLasso_Tst)
MSELasso_Tst = mean((yhatLasso_Tst-ytst)^2)
print(MSELasso_Tst)

tab3 <- table(pred = yhatLasso_Tst, true=ytst)
cm3 <-confusionMatrix(tab3) #Construct the confusion matrix
cm3$table #This prints the table
fourfoldplot(cm3$table, color = c("#66CDAA", "#40E0D0")) #Here is the Fancy plot
LASSO_Misclassifieds = cm3$table[1,2]+cm3$table[2,1]
LASSO_Misclassifieds

NumberOfMales = sum(y==0); NumberOfFemales = sum(y==1)
NumberOfMales
NumberOfFemales
