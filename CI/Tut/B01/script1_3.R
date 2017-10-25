library(lattice)
set.seed(793)

# Function gradPerc: Learn Single layer perceptron
  # Input 
    # x - features (input)
    # y - labels (output)
    # g - learning rate
    # it - maximum number of iterations
  # Output
    # w - perceptron weights

gradPerc = function(x, y, g, it){
  
  # transform data into appropriate format
  data = matrix(c(rep(1, dim(x)[2]), t(x)), nrow = (1 + dim(x)[1]), byrow = 1)
  
  # random initialisation of w = (theta, w1,..., wm)
  w = c(runif(dim(x)[1] + 1))
  
  # initialisation of vector for classification error
  err = rep(0, it + 1)
  err[1] = err(w, data, y)
  i = 1
  
  # run until all examples are classified correctly or until the maximum number of iterations
  while(err[i] > 0 & i <= it){
    
    i = i + 1
    
    # update the perceptron weights with gradient (batch) method and learning rate g
    w = w + g * gradient(w, data, y)
    
    # normalise the weights
    ### REFER TO Quiz ###
    w = w / abs(w[1])
    
    # compute error in current iteration
    err[i] = err(w, data, y)
  }
  
  # plot error over number of iterations
  plot((0:(i-1)), err[1:i], main = "Errors")
  
  return(w)
}

# Function gradient: compute gradient
  # Input
    # w - perceptron weights
    # x - features (input)
    # y - labels (output)
  # Output
    # gradient

sigmoid <- function(x, deriv){
    if(deriv == FALSE){
        return(1/(1+exp(-x)))
    }else{
        #return(x*(1-x))
        return(NULL)
    }
}
kl <- function(x){
    if(x<0){
        return(1)
    }else{
        return(0)
    }
}

gradient = function(w, x, y){
  
  # identify all incorrectly classified datapoints
  ###### CODE HERE ########
    w = t(as.matrix(w))
    predVec = w %*% x #sigmoid(w %*% x, FALSE) *2) - 1
    errorVec = predVec * y
    errorSums = -(x %*% t(errorVec))
 
  # return gradient
  ###### CODE HERE ########
    return(errorSums)
}

# Function err: compute number of classification errors
  # Input
    # w - perceptron weights
    # x - features (input)
    # y - labels (output)
  # Output
    # number of classification errors

err = function(w, x, y){
  
  # identify all incorrectly classified datapoints
  ###### CODE HERE ########
    w = t(as.matrix(w))
    predVec = w %*% x #(sigmoid(w %*% x, FALSE) *2) - 1
    errorVec = predVec * y
    errosSum = sum(apply(errorVec, 2, kl))

  # return number of classification errors
  ###### CODE HERE ########
    return(errosSum)
}

# read data from file
data = read.table("set2.txt", header = TRUE, sep = "\t")
names(data) = c("V1", "V2", "V3")

# separate and format data
x = t(data[ , 1:ncol(data) - 1])
label = t(data[ , ncol(data)]) # last column
label[label <= 0] = -1 # convert 0 to -1

# learn perceptron
w = gradPerc(x, label, 1, 100)
print(w)

#The following code adds a line to the scatterplot of the form y= a+b*x
#Calculate a and b such that the line represents the separation threshold defined by the
#learned weights of the perceptron
###### CODE HERE ########
a = w[1] / 1 #line intercept
b = -w[2] / w[3]#line slope

# line function
ablinePanel = function(x, y, ...) {
  panel.xyplot(x, y, ...)
  panel.abline(a, b, ...)
}

# plot data and seperator line
dev.new()
print(xyplot(V2 ~ V1, groups = V3, data, panel = ablinePanel, main = "Perceptron"))

