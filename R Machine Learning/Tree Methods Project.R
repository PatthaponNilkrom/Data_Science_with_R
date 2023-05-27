library(ISLR)
library(ggplot2)
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

df <- College
head(df)

# EDA
# Create a scatterplot Grad.Rate vs. Room.Board colored by Private
pl <- ggplot(df, aes(y=Grad.Rate,x=Room.Board, color = Private))
pl + geom_point(size = 2)

# Create a histogram of full time undergrad students, color by Private
pl2 <- ggplot(df, aes(F.Undergrad, fill=Private))
pl2 + geom_histogram(color = "black", position = position_stack(reverse = TRUE))

# Create a histogram of Grad.Rate colored by Private
pl3 <- ggplot(df, aes(Grad.Rate, fill=Private))
pl3 + geom_histogram(color = "black", position = position_stack(reverse = TRUE))

# Change that college's grad rate to 100%
df[df$Grad.Rate > 100,]
df[df$Grad.Rate > 100, "Grad.Rate"] <- 100

# Train Test Split
set.seed(24)
split = sample.split(df, SplitRatio = 0.70)
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Decision Tree model
tree.model <- rpart(Private ~ . , method='class', data= train)

# predict model tree
pt <- predict(tree.model, newdata = test)
pt <- as.data.frame(pt)
head(pt)

# Turn these two columns into one column to match the original
pt$Private <- ifelse(pt$Yes >= 0.5 , "Yes", "No")
table(test$Private,pt$Private)
prp(tree.model)

# Random Forest
rf.model <- randomForest(Private ~ .,data= train, importance=TRUE)
# confusion matrix
rf.model$confusion
# importance
rf.model$importance
# predict model randomForest
prf <- predict(rf.model, newdata = test)
head(prf)
table(prf,test$Private)
