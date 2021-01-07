### MY Eigenface "Decision tree":
graphics.off(); par("mar"); par(mar=c(1,1,1,1));
matlabTrain <- read.csv("MatTrain_70.csv")
matlabTest <- read.csv("MatTest_70.csv")
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
#-------------------------------------------------------- Decision tree
library(party)
library(tree)
MyTree <- tree(y~., matlabTrain[,2:Len[2]])
yhatTree_Trn <- predict(MyTree, newdata = matlabTrain[,2:Len[2]])
yhatTree_Trn = ifelse(yhatTree_Trn < .5, "0", "1")
yhatTree_Trn = as.numeric(yhatTree_Trn)
MSETree_Trn = mean((yhatTree_Trn - y)^2)
print(MSETree_Trn)

yhatTree_Tst <- predict(MyTree, newdata = matlabTest[,2:Len[2]])
yhatTree_Tst = ifelse(yhatTree_Tst < .5, "0", "1")
yhatTree_Tst = as.numeric(yhatTree_Tst)
MSETree_Tst = mean((yhatTree_Tst - ytst)^2)
print(MSETree_Tst)

tab4 <- table(pred = yhatTree_Tst, true=ytst)
cm4 <-confusionMatrix(tab4) 
cm4$table 
# par(mfrow = c(1, 2))
fourfoldplot(cm4$table,color = c("#CD5C5C", "#F08080"))
Tree_Misclassifieds = cm4$table[1,2]+cm4$table[2,1]
Tree_Misclassifieds
#-------------------------------------------------------- Cross validation
MyCV <- cv.tree(MyTree)
print(MyCV)
# par(mfrow = c(1, 2))
plot(MyCV$size, MyCV$dev, type = "b")
### The index of minimum number of missclassifieds obtained from cross validation is :
MinTree <- which.min(MyCV$dev)
print(MinTree)
### The minimum number of missclassifieds is:
MinNumbermissclassified = MyCV$dev[MinTree]
print(MinNumbermissclassified)
### The optimal number of folds of the cross-validation is:
OptimalTreeSize = MyCV$size[MinTree]
print(OptimalTreeSize)
### The plot of number of missclassified versus size of the tree is plotted bellow, and the red point shows 
points(MyCV$size[MinTree], MyCV$dev[MinTree], col = "red", cex = 2, pch = 20)
# plot(MyCV$k, MyCV$dev, type = "b")
# points(MyCV$k[MinTree], MyCV$dev[MinTree], col = "green", cex = 2, pch = 20)

title("Finding optimal size of the tree", cex.main = 1.5,   font.main= 2, col.main= "Black")

TreePrune <- prune.tree(MyTree, best = OptimalTreeSize)

yhatPruneTree_Tst <- predict(TreePrune, newdata = matlabTest[,2:Len[2]])
yhatPruneTree_Tst = ifelse(yhatPruneTree_Tst < .5, "0", "1")
yhatPruneTree_Tst = as.numeric(yhatPruneTree_Tst)
MSEPrunedTree_Tst = mean((yhatPruneTree_Tst - ytst)^2)
print(MSEPrunedTree_Tst)

tab5 <- table(pred = yhatPruneTree_Tst, true=ytst)
cm5 <-confusionMatrix(tab5) 
cm5$table 

fourfoldplot(cm5$table, color = c("#E9967A", "#FA8072"))
PruneTree_Misclassifieds = cm5$table[1,2]+cm5$table[2,1]
PruneTree_Misclassifieds

