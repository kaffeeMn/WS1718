## constants
NEURONS = 16
GRID = c(4,4)
ITER = 300000

## helpful methods
hebb_rule <- function(patterns){
    "
    applying the hebbs rule to all patterns
    @return: matrix containing the weights
    "
    n <- length(patterns[1,])
    mat <- matrix(0,n,n)
    tmpSum = 0
    for(i in (1:n)){
        for(j in (1:n)){
            tmpSum = 0
            for(k in (1:length(patterns[,1]))){
                tmpSum = tmpSum + (patterns[k,i] * patterns[k,j])
            }
            mat[i,j] = (tmpSum/n)
        }
        mat[i,i] = 0
    }
    return(mat)
}
hopfield <- function(state, weights,k){
    n <- length(state)
    result = 0
    for(j in (1:n)){
        result = result + (state[k] * weights[k,j])
    }
    return(sign(result))
}
## main
# initializing patterns
learningPatterns = matrix(0, 2, GRID[1]*GRID[2])
learningPatterns[1,] = c(
    -1,1,1,1, 
    1,-1,1,1, 
    1,1,-1,1, 
    1,1,1,-1
)
learningPatterns[2,] = c(
    1,1,1,1,
    -1,-1,-1,-1,
    1,1,1,1,
    -1,-1,-1,-1
)
testPatterns = matrix(0, 2, GRID[1]*GRID[2])
testPatterns[1,] = c(
    -1,1,-1,1, 
    1,-1,1,-1, 
    -1,1,-1,1, 
    1,-1,1,-1
)
testPatterns[2,] = c(
    1,1,1,1,
    -1,-1,1,-1,
    1,1,1,1,
    -1,-1,1,-1
)

learningResults = hebb_rule(learningPatterns)
print("learning results:")
print(learningResults)

print("training patterns:")
for(h in (1:length(testPatterns[,1]))){
    n = length(testPatterns[h,])
    status = testPatterns[h,]
    for(i in (1:ITER)){
        k = sample((1:n), 1, replace=TRUE)
        status[k] = hopfield(status, learningResults, k)
    }
    # final pattern
    print(t(matrix(status,4,4)))
    # differences to each learningpattern
    #print(t(matrix(status*learningPatterns[1,],4,4)))
    #print(t(matrix(status*learningPatterns[2,],4,4)))
    #print(' ')
}
