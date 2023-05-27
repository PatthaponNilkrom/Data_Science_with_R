# MoneyBall Project
# load data 'Batting'
library(dplyr)
library(ggplot2)

# Load Batting.csv
df <- read.csv('Batting.csv')
head(df)
str(df)
head(df$AB)
head(df$X2B)

# calculate
# Batting Average
df$BA <- df$H / df$AB
tail(df$BA,5)
# Creating X1B (Singles)
X1B <- df$H - df$X2B - df$X3B - df$HR
# On Base Percentage
df$OBP <- (df$H + df$BB + df$HBP)/(df$AB + df$BB + df$HBP + df$SF)
# Creating Slugging Average (SLG)
df$SLG <- (X1B + 2*df$X2B + 3*df$X3B + 4*df$HR)/df$AB


# Load Salaries.csv
sal <- read.csv('Salaries.csv')
summary(sal)


# merge data
# filter yearID 1985 and onwards
df <- subset(df, df$yearID >= 1985)
# merge df , sal by playerID , yearID
combo <- merge(df, sal, by = c('playerID', 'yearID'))
summary(combo)


# lost_players
# filter lost_players
lost_players <- subset(combo, combo$playerID %in% 
                         c("giambja01", "damonjo01", "saenzol01"))
# select playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB
lost_players <- subset(lost_players, lost_players$yearID == 2001, 
                       select = c(playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB))
# summarize mean(OBP) , sum(AB) from lost_players
lost_s <- summarize(lost_players, mean_OBP = mean(OBP), sum_AB = sum(AB))


# Replacement Players
# clear lost_players in 2001
combo_s <- subset(combo, !combo$playerID %in% 
                    c("giambja01", "damonjo01", "saenzol01") & combo$yearID == 2001)
# select columns 'playerID','OBP','AB','salary'
combo_s <- subset(combo_s, select = c('playerID','OBP','AB','salary'))
# clear missing value
combo_s <- subset(combo_s, ! is.na(combo_s$OBP))
# plot relation OBP , salary find insight
ggplot(combo_s,aes(x=OBP,y=salary)) + geom_point()

# filter clear high salary and OBP = 0
combo_s <- subset(combo_s, combo_s$salary < 8000000 & combo_s$OBP > 0)
# lost players sum_AB 1469 -> 1469/3 This is about 490
combo_s <- subset(combo_s, combo_s$AB >= 490)
# sort by OBP
combo_s <- arrange(combo_s, desc(OBP))
head(combo_s)
# Replacement Players == good_players
good_players <- combo_s[1:3,]
# summarize mean(OBP) , sum(AB) from good_players
good_ps <- summarise(good_players, mean_OBP = mean(OBP), 
                     sum_AB = sum(AB), sum_salary = sum(salary))


# summary Replacement Players
cat("[Lost Players] \nmean_OBP:",lost_s$mean_OBP, "\nsum_AB:", lost_s$sum_AB,
    "\n[Good Players] \nmean_OBP:", good_ps$mean_OBP, "\nsum_AB:", good_ps$sum_AB, "\ntotal_salary:", good_ps$sum_salary) 
