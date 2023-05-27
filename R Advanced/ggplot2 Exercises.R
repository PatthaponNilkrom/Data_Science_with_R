library(ggplot2)
library(ggthemes)
head(mpg)

# EX01 Histogram of hwy mpg values:
pl <- ggplot(mpg,aes(x=hwy))
pl + geom_histogram(bins=20,fill='salmon',alpha=0.8)

# EX02 Barplot of car counts per manufacturer with color fill defined by cyl count
pl <- ggplot(mpg, aes(y = manufacturer))
pl + geom_bar(aes(fill = factor(cyl))) + theme_gdocs()
# เราทำ cyl ให้เป็น factor เพื่อสร้างความเป็น order ให้กับมัน

# -> Switch now to use the txhousing dataset that comes with ggplot2

# EX03 Create a scatterplot of volume versus sales. 
# Afterwards play around with alpha and color arguments to clarify information.
df <- txhousing
pl <- ggplot(data=df,aes(x = volume,y= sales)) 
pl + geom_point(aes(color = sales),alpha=0.5)

# EX04 Add a smooth fit line to the scatterplot from above. Hint: 
# You may need to look up geom_smooth()
pl <- ggplot(data=df,aes(x = volume,y= sales)) 
pl + geom_point(aes(color= sales),alpha=0.5) + geom_smooth(color='red')
