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
