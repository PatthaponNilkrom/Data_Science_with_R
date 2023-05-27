library(ggplot2)
library(caTools)
library(e1071)

# load data
df <- read.csv("loan_data.csv")
head(df)
str(df)
summary(df)

# change class to factor
df$credit.policy <- factor(df$credit.policy)
df$inq.last.6mths <- factor(df$inq.last.6mths)
df$delinq.2yrs <- factor(df$delinq.2yrs)
df$not.fully.paid <- factor(df$not.fully.paid)
df$pub.rec <- factor(df$pub.rec)

# EDA
pl <- ggplot(df, aes(fico))
pl + geom_histogram(color = "black", aes(fill = not.fully.paid), position = position_stack(reverse = TRUE))

pl2 <- ggplot(df, aes(purpose))
pl2 + geom_bar(color = "black", aes(fill = not.fully.paid), position = "dodge") + theme(axis.text.x = element_text(angle = 90))

pl3 <- ggplot(df, aes(y = fico, x = int.rate))
pl3 + geom_point(aes(color = not.fully.paid), alpha = 0.4)


# Train and Test Sets
set.seed(20)
split <- sample.split(df$not.fully.paid, SplitRatio = 0.70)
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Building the Model
model <- svm(not.fully.paid ~ ., data=train)
summary(model)

# predict
p <- predict(model,test[,-14])
table(p,test$not.fully.paid)

# Tuning the Model
tune.results <- tune(svm,train.x=not.fully.paid ~.,data=train,kernel='radial',ranges=list(cost=c(1,10), gamma=c(0.1,1)))
summary(tune.results)

# Best performance
b.model <- svm(not.fully.paid ~ .,data=train,cost=1,gamma = 1)
b.p <- predict(b.model,test[,-14])
table(b.p,test$not.fully.paid)
cat("Acuracy:", round(mean(b.p == test$not.fully.paid)*100,2),"%")
