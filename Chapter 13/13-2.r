library(caret)
library(AppliedPredictiveModeling)

data(oil)
# use ?hepatic to see more details


library(MASS)
set.seed(975)

barplot(table(oilType),col=c("yellow"), main="Class Distribution")

#this gives 0 predictor with zero-variance
nearZeroVar(fattyAcids,saveMetrics =TRUE)

#remove the correlation between the predictors
highCorM<-findCorrelation(cor(fattyAcids),cutoff = .75)
filteredCorFatty <- fattyAcids[,-highCorM]

####### Nonlinear Discriminant Analysis ##########

ctrl <- trainControl(summaryFunction = defaultSummary)
set.seed(476)
mdaFit <- train(x = filteredCorFatty, 
                y = oilType,
                method = "mda",
                metric = "Accuracy",
                tuneGrid = expand.grid(.subclasses = 1:3),
                trControl = ctrl)
mdaPrediction<-predict(mdaFit,filteredCorFatty)
confusionMatrix(mdaPrediction,oilType)

############### Neural Networks #############

library(nnet)
set.seed(476)
nnetGrid <- expand.grid(.size = 1:10, .decay = c(0, .1, 1, 2))

maxSize <- max(nnetGrid$.size)

numWts <- 1*(maxSize * (6 + 1) + maxSize + 1) ## 6 is the number of predictors

nnetFit <- train(x = filteredCorFatty, 
                 y = oilType,
                 method = "nnet",
                 metric = "Accuracy",
                 preProc = c("center", "scale", "spatialSign"),
                 tuneGrid = nnetGrid,
                 trace = FALSE,
                 maxit = 2000,
                 MaxNWts = numWts,
                 trControl = ctrl)
nnetFit
