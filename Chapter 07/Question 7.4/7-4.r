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







# 









# 


#

# 



