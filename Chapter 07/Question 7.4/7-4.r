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
trainXnnet = trainFingerprints[,-tooHigh]
testXnnet = testFingerprints[,-tooHigh]
# 
# set.seed(12344)

nnetGrid <- expand.grid(.decay = c(0, 0.01, .1),
                        .size = c(1:10),
                        ## The next option is to use bagging (see the
                        ## next chapter) instead of different random
                        ## seeds.
                        .bag = FALSE)


nnetTune <- train(trainXnnet, trainFat,
                  method = "avNNet",
                  tuneGrid = nnetGrid,
                  trControl = ctrl,
                  ## Automatically standardize data prior to modeling
                  ## and prediction
                  preProc = c("center", "scale"),
                  linout = TRUE,
                  trace = FALSE,
                  MaxNWts = 10 * (ncol(trainXnnet) + 1) + 10 + 1,
                  maxit = 500)










# 


#

# 



