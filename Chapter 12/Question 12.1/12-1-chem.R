library(caret)
library(AppliedPredictiveModeling)

data(hepatic)
# use ?hepatic to see more details


library(MASS)
set.seed(975)

barplot(table(injury),col=c("yellow","red","green"), main="Class Distribution")


set.seed(975)

#------------------------------------------------------------------------
# Use the Chemical predictors:
#------------------------------------------------------------------------


# this gives removes near-zero variance 
# this is a categorical predictor and should remove near zero variance for this data
zv_cols = nearZeroVar(chem)
noZVChem = chem[,-zv_cols]


#remove the correlation between the predictors
highCorChem<-findCorrelation(cor(noZVChem),cutoff = .75)
filteredCorChem <- noZVChem[,-highCorChem]



# splitting data into 75% and 25% based on injury response
set.seed(975)
trainingRows =  createDataPartition(injury, p = .75, list= FALSE)

trainChem <- filteredCorChem[trainingRows,]
testChem <- filteredCorChem[-trainingRows, ]

trainInjury <- injury[trainingRows]
testInjury <- injury[-trainingRows]


ctrl <- trainControl(summaryFunction = defaultSummary)

############ Logistic Regression Analysis #############
# logistic regression

library(caret)
set.seed(975)
lrChem <- train(x=trainChem,
               y = trainInjury,
               method = "multinom",
