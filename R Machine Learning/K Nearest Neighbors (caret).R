library(caret)
library(ISLR)

df <- Caravan
str(df)
glimpse(df)

set.seed(99)
n <- nrow(df)
id <- sample(n, size = n*0.7,replace = F)
test.data <- df[id,]
train.data <- df[-id,]

#train model
set.seed(99)
k_grid <- data.frame(k = c(1:10))
#ctrl <- trainControl(method = 'cv', number = 5 , verboseIter = T)
knn_model <- train(Purchase ~ ., 
                   data = train.data, 
                   method = "knn",
                   tuneGrid = k_grid,
                   preProcess = c("center", "scale"),
                   trControl = ctrl)

# test model
p <- predict(knn_model, newdata = test.data)
mean(test.data$Purchase != p)

k.values <- 1:10
ac <- round(knn_model$results$Accuracy*100,2)

ac.df <- data.frame(k.values, ac)
ac.df <- rename(ac.df, "Accuracy %" = ac,"k" = k.values)
