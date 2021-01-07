### MY Eigenface "Linear regression(OLS)":
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

ytst <- matlabTest$Y


library(e1071)

set.seed(123)
fitSVM <- tune(svm, y ~ ., data = x, kernel = "linear")
summary(fitSVM)             