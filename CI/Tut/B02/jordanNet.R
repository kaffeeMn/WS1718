#require(RSNNS)
library(RSNNS)

# constants
SEED = 78
ITERATIONS = 1000

# helpfull methods
create_dataSet <- function(vec){
    inputs  = matrix(0,5,length(vec)-5)
    outputs = matrix(0,1,length(vec)-5)
    for(i in (1:(length(vec)-5))){
        inputs[,i] = vec[,(i:(i+4))]
        outputs[,i] = vec[,(i+5)]
    }
    results = list(x=inputs, y=outputs)
    return(results)
} 

# main
dSet = create_dataSet(as.matrix(read.table('data.txt',header=FALSE, sep=';')))

set.seed(SEED)
patterns    = splitForTrainingAndTest(t(dSet$x), t(dSet$y), ratio=0.15)
jordanModel = jordan(
    patterns$inputsTrain, patterns$targetsTrain, targetTest=patterns$targetsTest,
    maxit=ITERATIONS
)
names(jordanModel)

plotIterativeError(jordanModel)
plotRegressionError(patterns$targetsTrain, jordanModel$fitted.values)
