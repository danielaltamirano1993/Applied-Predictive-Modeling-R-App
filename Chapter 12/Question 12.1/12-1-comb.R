library(caret)
library(AppliedPredictiveModeling)

data(hepatic)
# use ?hepatic to see more details


library(MASS)
set.seed(975)

#this gives Z114 predictor has zero-variance
nearZeroVar(bio)

#remove the Z114 predictor and then find the correlation between the predictors
noZVbio <- bio[,-114]

#remove the correlation between the predictors
highCorBio<-findCorrelation(cor(noZVbio),cutoff = .75)
filteredCorBio <- noZVbio[,-highCorBio]


# this gives removes near-zero variance 
# this is a categorical predictor and should remove near zero variance for this data
zv_cols = nearZeroVar(chem)
noZVChem = chem[,-zv_cols]


#remove the correlation between the predictors
highCorChem<-findCorrelation(cor(noZVChem),cutoff = .75)
filteredCorChem <- noZVChem[,-highCorChem]

mergedPredictor <-data.frame(filteredCorBio,filteredCorChem)

# splitting data into 75% and 25% based on injury response
set.seed(975)
trainingRows =  createDataPartition(injury, p = .75, list= FALSE)

trainmergedPredictor <- mergedPredictor[trainingRows,]
testmergedPredictor <- mergedPredictor[-trainingRows, ]

trainInjury <- injury[trainingRows]
testInjury <- injury[-trainingRows]


ctrl <- trainControl(summaryFunction = defaultSummary)

############ Logistic Regression Analysis #############
# logistic regression

library(caret)
set.seed(975)
lrmergedPredictor <- train(x=trainmergedPredictor,
                y = trainInjury,
                method = "multinom",
                metric = "Accuracy",
                trControl = ctrl)


predictionLRmergedPredictor<-predict(lrmergedPredictor,testmergedPredictor)

confusionMatrix(data =predictionLRmergedPredictor,
                reference = testInjury)

#######################################################
############ Linear Discriminant Analysis #############

# LDA Analysis
library(MASS)
set.seed(975)

ldamergedPredictor <- train(x = trainmergedPredictor,
                 y = trainInjury,
                 method = "lda",
                 # preProc = c("center","scale"),
                 metric = "Accuracy",
                 trControl = ctrl)

predictionLDAmergedPredictor <-predict(ldamergedPredictor,testmergedPredictor)
confusionMatrix(data =predictionLDAmergedPredictor,
                reference = testInjury)
##########################################################################

############## Partial Least Squares Discriminant Analysis ###############
library(MASS)
set.seed(975)
plsmergedPredictor <- train(x = trainmergedPredictor,
                 y = trainInjury,
                 method = "pls",
                 tuneGrid = expand.grid(.ncomp = 1:4),
                 # preProc = c("center","scale"),
                 metric = "Accuracy",
                 trControl = ctrl)

predictionPLSmergedPredictor <-predict(plsmergedPredictor,testmergedPredictor)
confusionMatrix(data =predictionPLSmergedPredictor,
                reference = testInjury)
