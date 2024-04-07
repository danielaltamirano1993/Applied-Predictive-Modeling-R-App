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


