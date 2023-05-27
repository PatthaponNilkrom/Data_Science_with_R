library(dplyr)
library(Amelia)
library(ggplot2)
library(forcats)
library(caTools)
library(caret)
library(Metrics)

# load data
df <- read.csv("adult_sal.csv")
head(df)

# Drop column X
df <- select(df,-X)

str(df)
summary(df)

# Data Cleaning
table(df$type_employer)
any(is.na(df$type_employer))

# Combine Never-worked and Without-pay called "Unemployed"
"Unemployed" -> df[df$type_employer %in% c("Without-pay","Never-worked"),"type_employer"]
df[df$type_employer == "Unemployed",]

# Combine State-gov and Local-gov called "SL-gov"
"SL-gov" -> df[df$type_employer %in% c("State-gov","Local-gov"),"type_employer"]

# Combine Self-emp-inc and Self-emp-not-inc called "self-emp"
"self-emp" -> df[df$type_employer %in% c("Self-emp-inc","Self-emp-not-inc"),"type_employer"]

# Marital Column
table(df$marital)

# Reduce this to three groups
"Married" -> df[df$marital %in% c("Married-AF-spouse","Married-civ-spouse","Married-spouse-absent"),"marital"]
"Not-Married" -> df[df$marital %in% c("Separated","Widowed","Divorced"),"marital"]

# Country Column
table(df$country)

as <- c('China','Hong','India','Iran','Cambodia','Japan','Laos',
       'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')
naca <- c('Canada','United-States','Puerto-Rico' )
eu <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
        'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')
saca <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
          'El-Salvador','Guatemala','Haiti','Honduras',
          'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
          'Jamaica','Trinadad&Tobago')
oth <- c('South')

"Asia" -> df[df$country %in% as,"country"]
"North.America" -> df[df$country %in% naca,"country"]
"Europe" -> df[df$country %in% eu,"country"]
"Latin.and.South.America" -> df[df$country %in% saca,"country"]
"Other" -> df[df$country %in% oth,"country"]

# convert "?" to NA value
df[df == "?"] <- NA

# change character to factor levels
factor_df <- function(dt){
  out <- dt
  for (i in 1:length(dt)) {
    
    if (class(dt[[i]]) == "character"){
      out[[i]] <- factor(dt[[i]])
    }
      
    else{
      out[[i]] <- dt[[i]]
    }
      
  }
  return(out)
}
df <- factor_df(df)
str(df)

# missmap check NA
missmap(df, main="Missings Map", 
        y.at=c(1),y.labels = c(''),col=c("yellow", "black"))

# drop NA
df <- na.omit(df)
any(is.na(df))


# EDA Exploratory Data Analysis
str(df)

# create a histogram of ages, colored by income
pl <- ggplot(df, aes(age))
pl + geom_histogram(aes(fill=income), color= "black",binwidth=1)

# Plot a histogram of hours worked per week
pl2  <- ggplot(df, aes(hr_per_week))
pl2 + geom_histogram()

# Rename country column to region column
colnames(df)[colnames(df) == "country"] = "region"
head(df)
names(df)[names(df)=="country"] <- "region"

# Create a barplot of region fill color by income
pl3 <- ggplot(df,aes(x = fct_infreq(region))) + labs(x = "region")
pl3 + geom_bar(aes(fill = income), color= "black") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Building a Model
# Logistic Regression
head(df)

# Train Test Split
set.seed(24)
split = sample.split(df$income, SplitRatio = 0.70)
train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Training the Model
model <- glm(formula=income ~ . , family = binomial(logit),data = train)
summary(model)

# step()
# iteratively tries to remove predictor variables model
# attempt delete variables that do not significantly
new.model <- step(model)
summary(new.model)


#predict
p <- predict(new.model,newdata = test,type= "response")
result <- ifelse(p > 0.5,TRUE,FALSE)
test.con <- ifelse(test$income == ">50K",TRUE, FALSE)

# confusion matrix
con <- table(result,test.con)[2:1, 2:1]
# convert con to dataframe
con.df <- as.data.frame(con)


TP <- con.df$Freq[1]
TN <- con.df$Freq[4]
FP <- con.df$Freq[3]
FN <- con.df$Freq[2]

# Accuracy
ac <- (TN + TP)/sum(con.df$Freq)

# Recall : TP/(TP+FN)
rc <- TP/(TP + FN)

# Precision : TP/(TP+FP) 
pt <- TP/(TP+FP)

cat("Accuracy:",round(ac*100,1),"%\nRecall:",round(rc*100,1),"%\nprecision:",round(pt*100,1),"%")

# check confusion matrix -> caret
confusionMatrix(con)
recall(test.con,result)