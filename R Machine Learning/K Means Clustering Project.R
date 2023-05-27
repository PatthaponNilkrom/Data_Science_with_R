library(ggplot2)

# load data
df1 <- read.csv("winequality-red.csv", sep = ";")
df2 <- read.csv("winequality-white.csv", sep = ";")
head(df1)
head(df2)

# Create label column
df1$label <- "red"
df2$label <- "white"

# combine dataframe
wine <- rbind(df1,df2)
head(wine)
str(wine)

# EDA
# Create Histogram of residual.sugar Color by label
pl <- ggplot(wine, aes(residual.sugar))
pl + geom_histogram(bins = 50,aes(fill = label), color = "black", position = position_stack(reverse = TRUE)) + scale_fill_manual(values=c("#8c0728","#e3e1e1")) 

# Create Histogram citric.acid Color by label
pl2 <- ggplot(wine, aes(citric.acid))
pl2 + geom_histogram(bins = 50,aes(fill = label), color = "black", position = position_stack(reverse = TRUE)) + scale_fill_manual(values=c("#8c0728","#e3e1e1")) 

# Create Histogram alcohol Color by label
pl3 <- ggplot(wine, aes(alcohol))
pl3 + geom_histogram(bins = 50,aes(fill = label), color = "black", position = position_stack(reverse = TRUE)) + scale_fill_manual(values=c("#8c0728","#e3e1e1")) 

# Create scatterplot residual.sugar versus citric.acid, color label
pl4 <- ggplot(wine, aes(y = residual.sugar, x = citric.acid))
pl4 + geom_point(aes(color = label), alpha = 0.2) + scale_color_manual(values=c("#8c0728","#e3e1e1")) + theme_dark()

# Create scatterplot volatile.acidity versus residual.sugar, color by label
pl5 <- ggplot(wine, aes(x = volatile.acidity, y = residual.sugar))
pl5 + geom_point(aes(color = label), alpha = 0.2) + scale_color_manual(values=c("#8c0728","#e3e1e1")) + theme_dark()

# wine data without the label
clus.data <- wine[,-13]
head(clus.data)

# Building the Clusters
set.seed(24)
dfCluster <- kmeans(clus.data, 2, nstart = 20)
summary(dfCluster)

# evaluating the clusters
table(wine$label, dfCluster$cluster)

# Cluster Visualizations
clusplot(wine, dfCluster$cluster, color=TRUE, shade=TRUE, labels=0,lines=0, )
