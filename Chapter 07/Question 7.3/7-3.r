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








