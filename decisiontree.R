#Read data file
mydata <- read.csv("Cardiotocographic.csv", header = TRUE, sep ="_")
mydata<-Cardiotocographic
mydata$NSPF <- as.factor(mydata$NSP)

#Decision tree with party
library(party)
mytree <- ctree(NSPF~LB+AC+FM, mydata, controls=ctree_control(mincriterion=0.9, minsplit=50))
print(mytree)
plot(mytree,type="simple")

#Misclassification error
tab<-table(predict(mytree), mydata$NSPF)
print(tab)
1-sum(diag(tab))/sum(tab)
