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
