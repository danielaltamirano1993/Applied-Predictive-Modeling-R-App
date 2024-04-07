library(AppliedPredictiveModeling)
library(mlbench)
library(caret)
library(earth)
library(MASS)
library(elasticnet)
library(lars)
library(pls)
library(doParallel)
library(nnet)

data(permeability)


cat("After Non-Zero Variance, number of predictors in fingerprints is 388: \n")
NZVfingerprints <- nearZeroVar(fingerprints)
noNZVfingerprints <- fingerprints[,-NZVfingerprints]
print(str(noNZVfingerprints))
cat("\n\n")

# stratified random sample splitting with 75% training and 25% testing

set.seed(12345)
trainingRows =  createDataPartition(permeability, p = .75, list= FALSE)
trainFingerprints <- noNZVfingerprints[trainingRows,]
trainPermeability <- permeability[trainingRows,]

testFingerprints <- noNZVfingerprints[-trainingRows,]
testPermeability <- permeability[-trainingRows,]

set.seed(12345)

ctrl <- trainControl(method = "repeatedcv", repeats=5, number = 4)


# # For neuralnetwork, find the correlation and delete the correlated data
tooHigh <- findCorrelation(cor(trainFingerprints), cutoff = .75)
# 
# #  the tooHigh gives 99 correlated datas
# 
# set.seed(12344)











# 


#

# 



