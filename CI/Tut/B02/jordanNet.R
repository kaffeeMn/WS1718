library(RSNNS)

## constants
SEED = 78
ITERATIONS = 1000
LEARNING_RATE = 0.01

## helpfull methods
create_dataSet <- function(vec){
    "
    method to generate data from a one dimensional matrix

    @return: list $x -> input values for training and testing
                  $y -> output values for taining and testing
    "
    inputs  = matrix(0,5,length(vec)-5)
    outputs = matrix(0,1,length(vec)-5)
    for(i in (1:(length(vec)-5))){
        inputs[,i] = vec[,(i:(i+4))]
        outputs[,i] = vec[,(i+5)]
    }
    results = list(x=inputs, y=outputs)
    return(results)
} 

## main
# loading the dataset
dSet = create_dataSet(as.matrix(read.table('data.txt',header=FALSE, sep=';')))

# setting seed and using the net
set.seed(SEED)
patterns    = splitForTrainingAndTest(t(dSet$x), t(dSet$y), ratio=0.15)
jordanModel = jordan(
    patterns$inputsTrain, patterns$targetsTrain, 
    targetsTest=patterns$targetsTest, inputsTest=patterns$inputsTest,
    maxit=ITERATIONS, 
    learnFuncParams=c(LEARNING_RATE)
)
names(jordanModel)

# plotting outcomes
plotIterativeError(jordanModel, main='Iterative Error')
plotRegressionError(
    patterns$targetsTrain, jordanModel$fitted.values,
    main='Regressionerror For Training Data'
)
plotRegressionError(
    patterns$targetsTest, jordanModel$fittedTestValues,
    main='Regressionerror For Testing Data'
)
hist(
    jordanModel$fitted.values - patterns$targetsTrain,
    xlab='fitted.values - targetsTrain', col="lightblue"
    , main='Histogram Of Training Data'
)
