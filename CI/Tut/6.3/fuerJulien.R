# make sure you have installed combinat prior to the execution of this script
#packages.install('combinat')
library('combinat')

### constants
# for Q 1
HAP_I = t(matrix(
    c(3,1,4,2,5,
      1,2,5,3,4,
      1,5,4,2,3,
      2,3,4,1,5,
      3,4,1,2,5)
    , nrow = 5, ncol = 5
))
# for Q 2, 3, 5
HAP_II = t(matrix(
    c(3,1,4,2,5,
      5,2,1,3,4,
      1,5,4,2,3,
      2,3,4,1,5,
      3,4,1,2,5)
    , nrow = 5, ncol = 5
))
# for Q 4
#
# Assume you have 3 solutions listed in the following table, where A is short for Annie, B for Bernie etc.:
# 
# solution	T1	T2	T3	T4	T5
# i1	    C	A	B	D	E
# i2	    D	A	E	C	B
# i3	    A	D	B   E   C
#
# Which solutions would an SMS-EMOA with population size μ=2 select? Explain your answer visually.
SOL_STRING = t(matrix(
    c('C','A','B','D','E',
      'D','A','E','C','B',
      'A','D','B','E','C')
    , nrow = 5, ncol = 3
))
SOL_NUMERIC= t(matrix(
    c(2,3,1,4,5,
      2,5,4,1,3,
      1,3,5,2,4)
    , nrow = 5, ncol = 3
))

# identity matrix of B^5 
# (non neccessarily needed, since we can look up values inside the matrix rather than filtering with matrix multiplications)
E5 = list( c(1,0,0,0,0)
         , c(0,1,0,0,0)
         , c(0,0,1,0,0)
         , c(0,0,0,1,0)
         , c(0,0,0,0,1))
# list of the objective names (for plotting)
METHODS = c('minimum', 'minimal maximum', 'combined')



### mehtods for Q1 and Q2
validate <- function(perList, mat){
    all = matrix(0, length(perList), 2)
    for(i in (1:length(perList))){
        all[i,1] = evaluation(perList[[i]], mat, 1)
        all[i,2] = evaluation(perList[[i]], mat, 2)
    }
    return(all)
}
plotAllSolutions <- function(mat){
    per = permn((1:ncol(mat)))
    vals = validate(per, mat)
    print(vals[order(vals[,2]),])
    print(as.matrix(per)[order(vals[,2]),])
    plot(x=vals[,1], y=vals[,2], main="All Solutions",xlab="objective1", ylab="objective2")
}



### functions for EAs
evaluation <- function(x, mat, methodID){
    if(methodID == 1){
        # return sum of happyness values
        sum = 0
        for(i in (1:5)){
            sum = sum + mat[i,x[i]] #E5[[i]] %*% mat %*% E5[[x[i]]]
        }
        return(sum)
    }else if(methodID == 2){
        # returns the maximum happyness value (the least happy value)
        vals = c(0,0,0,0,0)
        for(i in (1:5)){
            vals[i] = mat[i,x[i]] #E5[[i]] %*% mat %*% E5[[x[i]]]
        }
        return(max(vals)) 
    }else{
        # returns sum of the previous methods
        sum = 0
        vals = c(0,0,0,0,0)
        for(i in (1:5)){
            sum = sum + mat[i, x[i]] # E5[[i]] %*% mat %*% E5[[x[i]]]
            vals[i] = mat[i, x[i]] #E5[[i]] %*% mat %*% E5[[x[i]]]
        }
        return(max(vals) + sum)
    }
}


### questions / tasks
Q1 <- function(mat=HAP_I){
    plotAllSolutions(mat)
}
Q2 <- function(mat=HAP_II){
    plotAllSolutions(mat)
}

main <- function(){
    # Just uncomment for whatever plots you want
    #Q1()
    #Q2()
}



### function calls
main()
