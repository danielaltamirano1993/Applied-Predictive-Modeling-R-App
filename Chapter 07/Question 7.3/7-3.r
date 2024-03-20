library(mlbench)
library(caret)
library(earth)
library(doParallel)
library(nnet)

data(tecator)

colName = {}
for (i in 1:100){
  colName[i]<- paste("X",i)
}
colnames(absorp)<-colName


# splitting data into 80% and 20% based on Fat Response
set.seed(12345)

trainingRows =  createDataPartition(endpoints[,2], p = .80, list= FALSE)

trainAbsorption <- absorp[ trainingRows, ]
testAbsorption <- absorp[-trainingRows, ]
trainFat <- endpoints[trainingRows, 2]
testFat <- endpoints[-trainingRows, 2]

ctrl <- trainControl(method = "repeatedcv", repeats=4)

# # For neuralnetwork, find the correlation and delete the correlated data
tooHigh <- findCorrelation(cor(trainAbsorption), cutoff = .80)

#  the tooHigh gives 99 correlated datas
trainXnnet1 = trainAbsorption[,-tooHigh]
testXnnet1 = testAbsorption[,-tooHigh]




