library(ggplot2)
library(caTools)
library(neuralnet)
library(randomForest)

# load data
df <- read.csv("bank_note_data.csv")
head(df)
str(df)

# EDA
ggplot(df, aes(x=Image.Var, y=Entropy, color = Class)) + geom_point()

ggplot(df, aes(x=Image.Skew, y=Entropy, color = Class)) + geom_point()

ggplot(df, aes(x=Image.Curt, y=Entropy, color = Class)) + geom_point()

ggplot(df, aes(x=Image.Curt, y=Image.Skew, color = Class)) + geom_point()

# Train Test Split
set.seed(24)
split = sample.split(df$Class, SplitRatio = 0.70)
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)
str(train)

# Building the Neural Net
nn <- neuralnet(Class~.,data=train,hidden=10,linear.output=FALSE)

# Predictions
p <- predict(nn, test[,-5])
head(p)

# set p as 0,1
p <- as.numeric(round(p,0))

# confusion matrix
table(test$Class,p)

# randomForest
# convert Class column to factor
df$Class <- factor(df$Class)
str(df)

# Train Test Split
set.seed(24)
split.rf = sample.split(df$Class, SplitRatio = 0.70)
train.rf = subset(df, split.rf == TRUE)
test.rf = subset(df, split.rf == FALSE)
str(train.rf)

# Built randomForest model
rf <- randomForest(Class ~ ., data= train.rf)

# predict
prf <- predict(rf,test.rf)

# confusion matrix
table(test.rf$Class,prf)
