library(ggplot2)
library(dplyr)
library(caTools)


# load data
df <- read.csv("bikeshare.csv")
class(df)
head(df)


# Exploratory Data
pl <- ggplot(df, aes(x = temp, y = count, color = temp)) 
pl + geom_point(alpha = 0.2)
# convert class datetime 
df$datetime <- as.POSIXct(df$datetime)
class(df$datetime)
# plot count dataetime
pl <- ggplot(df, aes(x = datetime, y = count, colour = temp)) 
pl + geom_point(alpha = 0.8) + scale_colour_gradient(high= "#f78656", low = "#56f7cf")


# correlation between temp and count
num.cols <- df[c("temp", "count")]
cor.data <- cor(num.cols)


# explore the season data
pl2 <- ggplot(df, aes(x = season, y = count, colour = factor(season)))
pl2 + geom_boxplot()
# we found A line can't capture a non-linear relationship.


# Create hour column from the datetime column
hr_time <- df[,1]
df$hour <- format(hr_time, "%H")


# workingday
df_w <- df[df$workingday == 1,]
pl3 <- ggplot(df_w, aes(y = count, x = hour, colour = temp))
pl3 + geom_point(position=position_jitter(w=1, h=0), alpha = 0.4) + scale_colour_gradientn(colors=c('blue','green','yellow','red'))

# non workingdays
df_nw <- df[df$workingday == 0,]
pl4 <- ggplot(df_nw, aes(y = count, x = hour, colour = temp))
pl4 + geom_point(position=position_jitter(w=1, h=0), alpha = 0.6) + scale_colour_gradientn(colors=c('blue','green','yellow','red'))


# we found peak activity during the morning (~8am)
# and right after work gets out (~5pm)


# Building the Model
# count(temp)
model <- lm(count ~ .,data = df)
summary(model)


# calculate
# ----
df_25 <- df[between(df$temp,25,26),]
df_0 <- df[between(df$temp,0,1),]
mean(df$temp)
mean(df_25$count)
slope_25 <- ( mean(df_25$count) )/( mean(df_25$temp) ) 
slope_x <-  ( mean(df$count) )/( mean(df$temp) ) 
# -----

# All data
# train
temp.model <- lm(count ~ temp,data = df)
summary(temp.model)

# test an temp 25 
temp.test <- data.frame(temp=c(25))

# predict
pa <- predict(temp.model,temp.test)

# split data
set.seed(33) 
sample <- sample.split(df$temp, SplitRatio = 0.70)

# Training Data
train = subset(df, sample == TRUE)
model <- lm(count ~ temp,train)
summary(model)

# Testing Data
test = subset(df, sample == FALSE)

# predict data
p <- predict(model,test)
mean(p)
results <- cbind(p,test$count) 
colnames(results) <- c('pred','real')
results <- as.data.frame(results)

# mean squared error
mse <- mean((results$real-results$pred)^2)

# root mean squared error
mse^0.5

# R-Squared Value
SSE <- sum((results$pred - results$real)^2)
SST <- sum( (mean(df$count) - results$real)^2)
R2 <- 1 - SSE/SST

# we found model doesn't work well given our seasonal and time series data


# multiple variable model
# change the hour column to a column of numeric values
df$hour <- sapply(df$hour,as.numeric)

# count(season + holiday + workingday + weather + temp + humidity + windspeed + hour (factor))
model_ncrda <- lm(count ~ . -casual - registered -datetime -atemp,df )
summary(model_ncrda)
