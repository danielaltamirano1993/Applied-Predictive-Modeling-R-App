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
