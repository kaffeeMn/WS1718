#require(RSNNS)
library(RSNNS)

# constants
SEED = 78

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
print(dSet)
#print(dSet$x)
#print(dSet$y)
#patterns = splitForTrainingAndTest(dSet, dSet)
#
#modelJordan <- jordan(
#    
#)
