library(AppliedPredictiveModeling)
library(MASS)
library(caret)
library(elasticnet)
library(lars)
library(pls)


#########################
######################### 
cat("Before Non-Zero Variance, number of predictors in fingerprints is 1107: \n")
cat("\n\n")

cat("After Non-Zero Variance, number of predictors in fingerprints is 388: \n")

#########################
#########################

#########################
######################### 









cat("\n")

# # Ridge Regression Method
# permeabiltyRg <- train(x = trainFingerprints , y = trainPermeability, method = "ridge",
#                 trControl = ctrl,
#                 preProcess = c("center","scale"),
#                 tuneGrid = expand.grid(lambda = seq(0,1,length=15)))
# 
# print(permeabiltyRg)
# plot(permeabiltyRg, metric ="Rsquared", main = "Ridge Regression Tuning Parameter for Permeability Data")
# 
# 
# # Lasso Regression Method
# meatLasso <- train(x = trainFingerprints , y = trainPermeability, method = "lasso",
#                    trControl = ctrl,
#                    preProcess = c("center","scale"),
#                    tuneGrid = expand.grid(fraction = seq(0.1,1,length=20)))
# 
# print(meatLasso)
# plot(meatLasso)
# cat("\n")
