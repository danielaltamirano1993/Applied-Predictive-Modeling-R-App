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



