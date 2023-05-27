# Exercise Problems
# Ex 1: Write a script that will print "Even Number" if the variable x is an even number , 
# otherwise print "Not Even":
x <- 2
if (x %% 2 == 0) {
  print("Even Number")
} else{
  print("Odd Number")
}

# Ex 2: Write a script that will print 'Is a Matrix' if the variable x is a matrix ,
# otherwise print "Not a Matrix". Hint: You may want to check out help(is.matrix)
x <- matrix()
if (is.matrix(x)) {
  print("Is a Matrix")
} else{
  print("Not a Matrix")
}

# Ex 3: Create a script that given a numeric vector x with a length 3, 
# will print out the elements in order from high to low. You must use if,else if, 
# and else statements for your logic. (This code will be relatively long)
x <- c(1,4,4)
if (x[1] == max(x)) {
  f <- x[1]
  if (x[2] >= x[3]) {
    s <- x[2]
    th <- x[3]
  } else {
    s <- x[3]
    th <- x[2]
  }
} else if (x[2] == max(x)) {
  f <- x[2]
  if (x[1] >= x[3]){
    s <- x[1]
    th <- x[3]
  } else {
    s <- x[3]
    th <- x[1]
  }
} else {
  f <- x[3]
  if (x[1] >= x[2]) {
    s <- x[1]
    th <- x[2]
  } else {
    s <- x[2]
    th <- x[1]
  }
} 
print(paste(f,s,th))
# สามารถใช้ sort(x, decreasing = FALSE) ได้

# Ex 4: Write a script that uses if,else if, and else statements 
# to print the max element in a numeric vector with 3 elements.
x <- c(20, 10, 1)

if (x[1] > x[2] & x[1] > x[3] ) {
    print(x[1] )
} else if (x[2] > x[3] ) {
    print(x[2])
} else {
    print(x[3])
}
