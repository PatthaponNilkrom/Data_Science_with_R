library(ISLR)
library(caTools)
library(class)
library(ggplot2)

df <- iris
head(df)
str(df)

# Standarize
stz.df <- scale(df[, -5])

# Check variance
var(stz.df[,1])
var(stz.df[,2])

class(stz.df)
# Join the standardized data with the species column
stz.df <- cbind(stz.df,df[5])

# Train and Test Splits
set.seed(24)
split = sample.split(stz.df, SplitRatio = 0.70)
train = subset(stz.df, split == TRUE)
test = subset(stz.df, split == FALSE)

# Build a KNN model
model <- knn(train[1:4],test[1:4],train$Species,k=1)
table(model)

# misclassification rate
mean(test$Species != model)

# Choosing a K Value
model = NULL
error.rate = NULL
for(i in 1:10){
  set.seed(24)
  model = knn(train[1:4],test[1:4],train$Species,k=i)
  error.rate[i] = mean(test$Species != model)
}

error.rate

k.values <- 1:10
error.df <- data.frame(error.rate,k.values)
ggplot(error.df,aes(x=k.values,y=error.rate)) + geom_point()+ geom_line(lty="dotted",color='red')
