library(caret)
library(AppliedPredictiveModeling)

data(hepatic)
# use ?hepatic to see more details


library(MASS)
set.seed(975)

barplot(table(injury),col=c("yellow","red","green"), main="Class Distribution")

#------------------------------------------------------------------------
# Use the biological predictors:
#------------------------------------------------------------------------


#this gives Z114 predictor has zero-variance
nearZeroVar(bio)

#remove the Z114 predictor and then find the correlation between the predictors
noZVbio <- bio[,-114]

#remove the correlation between the predictors
highCorBio<-findCorrelation(cor(noZVbio),cutoff = .75)
filteredCorBio <- noZVbio[,-highCorBio]



# splitting data into 75% and 25% based on injury response
set.seed(975)
trainingRows =  createDataPartition(injury, p = .75, list= FALSE)

trainBio <- filteredCorBio[ trainingRows, ]
testBio <- filteredCorBio[-trainingRows, ]


trainInjury <- injury[trainingRows]
testInjury <- injury[-trainingRows]


ctrl <- trainControl(summaryFunction = defaultSummary)

############ Logistic Regression Analysis #############
# logistic regression

library(caret)
set.seed(975)
lrBio <- train(x=trainBio,
               y = trainInjury,
               method = "multinom",
               metric = "Accuracy",
               trControl = ctrl)


predictionLRBio<-predict(lrBio,testBio)

confusionMatrix(data =predictionLRBio,
                reference = testInjury)

#######################################################
############ Linear Discriminant Analysis #############

# LDA Analysis
library(MASS)
set.seed(975)


ldaBio <- train(x = trainBio,
                y = trainInjury,
                method = "lda",
                metric = "Accuracy",
