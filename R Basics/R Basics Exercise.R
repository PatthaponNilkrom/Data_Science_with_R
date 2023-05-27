# What is two to the power of five?
2**5
2^5
# -> 32

# Create a vector called stock.prices with the following data points: 23,27,23,21,34
stock.prices <- c(23,27,23,21,34)
stock.prices
# -> 23 27 23 21 34

# Assign names to the price data points relating to the day of the week, 
# starting with Mon, Tue, Wed, etc...
names(stock.prices) <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri')
stock.prices
# -> Mon Tue Wed Thu Fri 
# -> 23  27  23  21  34

# What was the average (mean) stock price for the week? 
# (You may need to reference a built-in function)
mean(stock.prices)
# -> 25.6

# Create a vector called over.23 consisting of logicals 
# that correspond to the days where the stock price was more than $23
over.23 <- stock.prices > 23
over.23
# -> 
over.23 <- stock.prices[stock.prices > 23]
over.23

stock.prices[over.23]
# -> Tues Fri
# -> 27 34

# Use a built-in function to find the day the price was the highest
max(stock.prices)
max.price <- stock.prices == max(stock.prices)
stock.prices[max.price]
# -> Fri: 34
