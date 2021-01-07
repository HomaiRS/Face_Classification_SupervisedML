### MY Eigenface "Linear regression(OLS)":
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
x <- as.matrix(matlabTrain[,2:Len[2]])

ytst <- matlabTest$Y
#-------------------------------------------------------- Plotting images
# graphics.off(); par("mar"); par(mar=c(1,1,1,1));
# par(mfrow=c(4,4))
# for (i in 1:16){
#   im <- matrix(as.numeric(matlabTrain[i,1:Len[2]]), nrow = 128, ncol = 128)
#   image(t(apply(im,1,rev)),col=gray((0:128)/128))
# }
#-------------------------------------------------------- Linear regression
OLS = lm(y~.,data = matlabTrain[,2:Len[2]]) 
Betacoef = coef(OLS);
# print(Betacoef)
#########---------------------Linear regression train error
yhatOLS <- predict(OLS, matlabTrain[,2:Len[2]])
yhatOLS = ifelse(yhatOLS < .5, "0", "1")
yhatOLS = as.numeric(yhatOLS)
MSEOLS = mean((yhatOLS-y)^2)
print(MSEOLS)
table(pred = yhatOLS, true=y)
#########---------------------Linear regression test error
OLS = lm(y~.,data = matlabTrain[,2:Len[2]]) 
yhatOLS_Tst <- predict(OLS, matlabTest[,2:Len[2]], type="response")
yhatOLS_Tst = ifelse(yhatOLS_Tst < .5, "0", "1")
yhatOLS_Tst = as.numeric(yhatOLS_Tst)
MSEOLS = mean((yhatOLS_Tst-ytst)^2)
print(MSEOLS)

tab0 <- table(pred = yhatOLS_Tst, true=ytst)
cm0<-confusionMatrix(tab0) 
fourfoldplot(cm0$table)
OLS_Misclassifieds = cm0$table[1,2]+cm0$table[2,1]
OLS_Misclassifieds

NumberOfMales = sum(y==0); NumberOfFemales = sum(y==1)
NumberOfMales
NumberOfFemales
NumberOfMales+NumberOfFemales
dim(matlabTest)
dim(matlabTrain)
