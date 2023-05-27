# EXAMPLE 1: Create a function that takes in a name as a string argument, 
# and prints out "Hello name"
hello_you <- function(name){
    print(paste('Hello',name))
}
hello_you('Sam')

# EXAMPLE 2: Create a function that takes in a name as a string argument and returns a 
# string of the form - "Hello name"
hello_you2 <- function(name){
  print(paste('hello ',name))
}
print(hello_you2('Sam'))

# Ex 1: Create a function that will return the product of two integers.
prod <- function(num1, num2) {
  return(num1*num2)
}
prod(3,4)

# Ex 2: Create a function that accepts two arguments, an integer and a vector of integers. 
# It returns TRUE if the integer is present in the vector, otherwise it returns FALSE. 
# Make sure you pay careful attention to your placement of the return(FALSE) 
# line in your function!
num_check <- function(num,v){
  for (item in v){
    if (item == num){
      return(TRUE)
    }
  }
  return(FALSE)
}
num_check(2,c(1,2,3))

# Ex 3: Create a function that accepts two arguments, an integer and a vector of integers. 
# It returns the count of the number of occurences of the integer in the input vector.
num_count <- function(num,v){
  count = 0
  for (x in v){
    if (x == num){
      count = count + 1
    }
  }
  return(count)
}
num_count(1,c(1,1,2,2,3,1,4,5,5,2,2,1,3))

# Ex 4: We want to ship bars of aluminum. We will create a function that accepts an 
# integer representing the requested kilograms of aluminum for the package to be shipped. 
# To fullfill these order, we have small bars (1 kilogram each) and big bars 
#(5 kilograms each). Return the least number of bars needed.

# For example, a load of 6 kg requires a minimum of two bars (1 5kg bars and 1 1kg bars). 
# A load of 17 kg requires a minimum of 5 bars (3 5kg bars and 2 1kg bars).
bar_count <- function(n) {
  count = 0
  while (n > 0) {
    if (n %% 5 == 0) {
      n = n - 5
      count = count + 1
    } else {
      n = n - 1
      count = count + 1
    }
  } 
  return(count)
}
bar_count(17)

# Ex 5: Create a function that accepts 3 integer values and returns their sum. 
# However, if an integer value is evenly divisible by 3, 
# then it does not count towards the sum. Return zero if all numbers are evenly 
# divisible by 3. Hint: You may want to use the append() function.
summer <- function(n1,n2,n3) {
  x = c()
  for (n in c(n1,n2,n3)) {
    if (n %% 3 == 0) {
      x <- append(x,0)
    } else { 
      x <- append(x,n)
    }
  }
  return(sum(x))
} 
summer(7,2,3)

# Ex 6: Create a function that will return TRUE if an input integer is prime. 
# Otherwise, return FALSE. You may want to look into the any() function. 
# There are many possible solutions to this problem.
prime_check <- function(num) {
  if (num == 2) {
    return(TRUE)
  } else if (any(num %% 2:(num-1) == 0)) {
    return(FALSE)
  } else { 
    return(TRUE)
  }
}
prime_check(5)

# OR
prime_check <- function(num){
  # Could put more checks for negative numbers etc...
  if (num == 2) {
    return(TRUE)
  }
  for (x in 2:(num-1)){
    
    if ((num%%x) == 0){
      return(FALSE)
    }
  }
  return(TRUE)
}
prime_check(11)
prime_check(237)
