library(ggplot2)
library(data.table)

# get data
df <- fread('Economist_Assignment_Data.csv', drop=1)
head(df)

# create a scatter plot object called pl
pl <- ggplot(data=df,aes(x = CPI,y = HDI)) 
pl + geom_point(aes(color=Region))

# Change the points to be larger empty circles
pl <- ggplot(data=df,aes(x = CPI,y = HDI)) 
pl + geom_point(shape = "circle open", size = 2 ,aes(color = Region))

# Add geom_smooth(aes(group=1)) to add a trend line
pl <- ggplot(data=df,aes(x = CPI,y = HDI)) 
pl + geom_point(shape = "circle open", size = 2 ,aes(color = Region)) +
  geom_smooth(aes(group=1))

# Add the following arguments to geom_smooth
pl2 <- pl + geom_point(shape = "circle open", size = 2 ,aes(color = Region)) +
  geom_smooth(aes(group=1), method = 'lm',
              formula = y ~ log(x),
              se = FALSE,
              color = 'red')

# Add geom_text(aes(label=Country)) to pl2
pl2 + geom_text(aes(label=Country))

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

# Add theme_bw() to your plot and save this to pl4
pl4 <- pl3 + theme_bw()

# Add scale_x_continuous
pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                         breaks = 1:10, limits = c(.9, 10.5))
                         
# Add scale_y_continuous
pl5 <- pl4 + scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                         breaks = 1:10, limits = c(.9, 10.5)) +
  scale_y_continuous(name = "Human Development Index, 2011 (1 = Best)",
                      breaks = 1:10, limits = c(0.2, 1.0))

pl6 <- pl5 + ggtitle("Corruption and Human development")

# use ggthemes library
library(ggthemes)
pl6 + theme_economist_white()
