# Function backpropLearn: backpropagation learning in specific ANN
  # Input
    # input - features (input)
    # output - output
    # r - learning rate
    # eps - convergence threshold
    # it - maximum number of iterations
  # Output
    # w - ANN weights

backpropLearn = function(input, output, r, eps, it){
  
  # random initialisation of weights
  set.seed(1) # deterministic for comparison
  w = runif(6)
  
  # initialisation of vector for error
  err = rep(100, it)
  i = 1
  
  # update weights until error is small enough or maximum number of iterations is reached
  while( i == 1 || (err[i-1] > eps & i <= it)){
    
    err[i] = 0
    
    # iterate over all data points
    for(j in 1:length(output)){
      
      # compute current output
      out = annEval(w, input[j, ])
      d = vector(length = 3)
  
      # compute d and update w
      ###### CODE HERE ########
      d[3] = out[3] * (1- out[3]) *(out[3] * output[j])
      d[1] = out[1] * (1 - out[1]) * d[3] * w[5]
      d[2] = out[2] * (1 - out[2]) * d[3] * w[6]

      w[1] = w[1] - r*(input[j,1] * d[1])
      w[2] = w[2] - r*(input[j,1] * d[2])
      w[3] = w[3] - r*(input[j,2] * d[1])
      w[4] = w[4] - r*(input[j,2] * d[2])
      w[5] = w[5] - r*(out[1] * d[3])
      w[6] = w[6] - r*(out[2] * d[3])
      
      # calculate error
      err[i] = err[i] + abs(annEval(w, input[j, ])[3] - output[j])
    }
    i = i + 1
  }
  # plot error over number of iterations
  plot(1:(i-1), err[1:i-1], main = "Errors")
  
  return(w)
}

# Function annEval: evaluation of specific ANN
  # Input
    # w - weights in ANN
    # input - input values
  # Output
    # out - ANN output for each neuron

annEval = function(w, input){
  out = vector(length = 3)
  
  # calculate output for each neuron using function a
  out[1] = a(input[1] * w[1] + input[2] * w[3])
  out[2] = a(input[1] * w[2] + input[2] * w[4])
  out[3] = a(out[1] * w[5] + out[2] * w[6])
  
  return(out)
}


# Function a: sigmoid function
  # Input
    # x - real number
  # Output
    # a(x)

a = function(x){
  return(1 / (1 + exp(-x)))
}

# create input data
input = matrix(c(0.1, 0.7, 0.2, 0.5), ncol = 2)
output = c(1, 1)

# learn network
w = backpropLearn(input, output, 1, 0.2, 100)
print(w)

# read data from file
#data = read.table("../set1.txt", header = TRUE, sep = "\t")

# separate data
#names(data) = c("V1", "V2", "V3")
#x = as.matrix(data[ ,1:ncol(data) - 1])
#label = data[ ,ncol(data)] # last column
#
#w = backpropLearn(x, label, 1, 0.2, 1000)
#print(w)


