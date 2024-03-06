library(caret)
library(kernlab)
library(lattice)
library(ggplot2)

x<-runif(100,min=2,max=10)
y<-sin(x)+rnorm(length(x))*0.25
sinData<-data.frame(x=x,y=y)

# create a data Grid
dataGrid<-data.frame(x=seq(2,10,length=100))

# this is done to divide the graph in 4 columns
par(mfrow = c(2,2))

                 kernel="rbfdot",kpar="automatic",
                 C= svmParam1$costs[i],epsilon = svmParam1$eps[i])
  
  
  
  
}





