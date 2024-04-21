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

# after removing the highly correlated predictor, we split the data using 
# stratified random sampling

# splitting data into 80% and 20% based on oilType response

set.seed(975)
trainingRows =  createDataPartition(oilType, p = .80, list= FALSE)

trainFattyAcids <- filteredCorFatty[ trainingRows, ]
testFattyAcids <- filteredCorFatty[-trainingRows, ]

trainOilType <- oilType[trainingRows]
testOilType <- oilType[-trainingRows]

ctrl <- trainControl(summaryFunction = defaultSummary)

############ Logistic Regression Analysis #############
# logistic regression

library(caret)
set.seed(975)
lrFattyAcids <- train(x=trainFattyAcids,
               y = trainOilType,
               method = "multinom",
               metric = "Accuracy",
               trControl = ctrl)


predictionLRFattyAcids<-predict(lrFattyAcids,testFattyAcids)

confusionMatrix(data =predictionLRFattyAcids,
                reference = testOilType)

#######################################################
############ Linear Discriminant Analysis #############

# LDA Analysis
library(MASS)
set.seed(975)


ldaFattyAcids <- train(x = trainFattyAcids,
                y = trainOilType,
                method = "lda",
                metric = "Accuracy",
                trControl = ctrl)

predictionLDAFattyAcids <-predict(ldaFattyAcids,testFattyAcids)
confusionMatrix(data =predictionLDAFattyAcids,
                reference = testOilType)
##########################################################################

############## Partial Least Squares Discriminant Analysis ###############
library(MASS)
set.seed(975)
plsFattyAcids <- train(x = trainFattyAcids,
