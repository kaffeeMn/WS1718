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
tSwap <- function(x){
    i = sample(1:5,2,replace=F)
    tmp = x[i[1]]
    x[i[1]] = x[i[2]]
    x[i[2]] = tmp
    return(x)
}
kSwap <- function(x, range=10){
    k = sample(1:range, 1)
    for(i in (1:k)){
        x = tSwap(x)
    }
    return(x)
}



### functions for a (1+1)EA
EA11 <- function(mat, methodID=1, stopMax=10){
    print(METHODS[methodID])

    # values for plots
    plotVals = c()
    plotValsIdx = 1

    # initialize
    vec2S = sample(1:5,5,replace=F)
    vecKS = sample(1:5,5,replace=F)

    # evaluate parents
    eval2S = c(0,0) 
    evalKS = c(0,0)
    eval2S[1] = evaluation(vec2S, mat, methodID)
    evalKS[1] = evaluation(vecKS, mat, methodID)
    
    stopCount = 0
    parent = c(0,0,0,0,0)

    while(stopCount < stopMax){
        plotVals$KS[plotValsIdx] = evalKS[1]
        plotVals$TS[plotValsIdx] = eval2S[1]
        plotValsIdx = plotValsIdx + 1

        # varition, yielding offspring (our option: mutations)
        cld2S = tSwap(vec2S)
        cldKS = kSwap(vecKS)
        # evaluate offspring
        eval2S[2] = evaluation(vec2S, mat, methodID)
        evalKS[2] = evaluation(vecKS, mat, methodID)
        # printing states if supervision is desired at this point
        #print(evalKS)
        #print(eval2S)
        #print(list(parentKS=vecKS, childKS=cldKS))
        #print(list(parent2S=vec2S, child2S=cld2S))
        #print("")
        # select survivors and check for stop
        sameKS = T
        same2S = T
        if(eval2S[1] >= eval2S[2]){
            vec2S = cld2S
            eval2S[1] = eval2S[2]
            same2S = F
        }
        if(evalKS[1] >= evalKS[2]){
            vecKS = cldKS
            evalKS[1] = evalKS[2]
            sameKS = F
        }
        if(sameKS && same2S){
            stopCount = stopCount + 1
        }else{
            stopCount = 0
        }
    }

    # returning the best solution of 2Swap and KSwap
    if(eval2S[1] < evalKS[1]){
        return(list( res = vec2S, plot = plotVals ))
    }
    return(list( res = vecKS, plot = plotVals ))
}

plotEA11 <- function(mat, id){
    # running the algorithm
    min = EA11(mat, id)
    # collecting results and values for the plots
    resMin  = min$res
    plotMin = min$plot
    # plotting results
    title = paste("Iterations 2Swap (objective", METHODS[id], ")")
    plot(plotMin$TS, type="l", main=title)
    title = paste("Iterations KSwap (objective", METHODS[id], ")")
    plot(plotMin$KS, type="l", main=title)
    title = paste("Index best solution (objective", METHODS[id], ")")
    plot(resMin, type="h", main=title)
    hapMin = c()
    for(i in (1:5)){
        hapMin[i] = E5[[i]] %*% mat %*% E5[[resMin[i]]]
    }
    title = paste("Happyness best solution (objective", METHODS[id], ")")
    plot(hapMin, type="h", main=title)
}



### functions for the SMS-EMOA
variate <- function(mat){
    # obx for variation
    ret = c(0,0,0,0,0)
    idxs = sample((1:5), 2, replace=F)
    parent = sample((1:3), 2, replace=F)

    ret[(idxs[1]:idxs[2])] = mat[parent[1],idxs[1]:idxs[2]]
    k = max(idxs) + 1
    for(i in (1:5)){
        if(k > 5){
            k = 1
        }
        if(!(mat[parent[2],i] %in% ret)){
            ret[k] = mat[parent[2],i]
            k = k+1
        }
    }

    # 2Swap for mutation
    return(tSwap(ret))
}
dominance <- function(pop, mat){
    maxRow = nrow(mat)
    # dom[[rowIdx]] = domination number
    dom = list()
    evalsMID1 = c()
    evalsMID2 = c()
    # using evaluation method 1 (for x axis)
    for(i in (1:nrow(pop))){
        evalsMID1[i] = evaluation(pop[i,], mat, 1)
    }
    # using evaluation method 2 (for y axis)
    for(i in (1:nrow(pop))){
        evalsMID2[i] = evaluation(pop[i,], mat, 2)
    }
    # checking for dominating points
    for(i in (1:nrow(pop))){
        domNum = 0
        for(j in (1:nrow(pop))){
            if(j != i){
                if(evalsMID1[i] >= evalsMID1[j] && evalsMID2[i] >= evalsMID2[j]){
                    domNum = domNum + 1
                }
            }
        }
        # returns empty list, if no dominating solutions were found
        if(domNum != 0){
            dom[[i]] = domNum
        }
    }
    return(dom)
}
maxDom <- function(domList){
    # returning the rownumber with the biggest domination number
    rowIdx = 0
    max = 0
    for(i in (1:length(domList))){
        if(!is.null(domList[[i]]) && domList[[i]] > max){
            max = domList[[i]]
            rowIdx = i
        }
    }
    return(rowIdx)
}
minSM <- function(pop, ref){
    # returning the rownumber with the minimal s-metrik-contribution
    dct = list()
    # values for the points ( vals = [[xVal, yVal, rowNum]] )
    vals = matrix(0,nrow(pop),3)
    for(i in (1:nrow(ref))){
       vals[i,] = c(evaluation(pop[i,], 1), evaluation(pop[i,],2), i)
    }
    # sorting by x value
    vals = vals[order(vals[,1]),]
    # now that we can be reference nieghbouring points, we may calculate the s-metric contributions
    # contributions to the hypervolume ( volumes = [[volume, rowNum]] )
    volumes     = matrix(0,nrow(pop),2)
    # cases for the edges
    maxRow = nrow(vals)
    volumes[1,] = c((ref[2] - vals[1,2]) * (vals[2,1] - vals[1,1]), vals[1,3])
    volumes[1,] = c((vals[(maxRow-1),2] - vals[(maxRow),2]) * (ref[1] - vals[maxRow,1]), vals[maxRow,3])
    # calculating volumes for all other points
    for(i in (2:(maxRow-1))){
        volumes[i] = c((vals[i-1,2] - vals[i,2]) * (vals[i+1,1] - vals[i,1]), vals[i,3])
    }
    # sort for minimum volumes
    min = volumes[order(volumes[,1]),]
    # returning the original row number
    return(min[1,3])
}
clean <- function(mat, row){
    # deletes row and shifts rows left logically
    maxRow = nrow(mat)
    retMat = matrix(0, maxRow, ncol(mat))
    retMat[1:(row-1),] = mat[1:(row-1),]
    if(row < maxRow){
        retMat[row:(maxRow-1),] = mat[(row+1):maxRow,]
    }
    retMat[maxRow,] = c(0,0,0,0,0)
    return(retMat)
}

SMSEMOA <- function(refP, mat=HAP_II, popSize=3, maxIt=100){
    # list for population and offspring
    generations = list()
    # filling our population with <popSize> random individuals
    pop = matrix(0,(popSize+1),5)
    for(i in (1:popSize)){
        pop[i,] = sample((1:5),5,replace=F)
    }
    # initializing generation counter
    gen = 1
    generations[[gen]] = pop
    pop = NULL
    # repeating while the termination criterium is invalid (in this case a fixed number of iterations)
    it = 1
    for(it in (1:maxIt)){
        pop = generations[[gen]]
        # order-based crossover (OBX) as variation operator
        pop[popSize+1,] = variate(pop[1:popSize,])

        # plotting to check
        if(it %% 10 == 0){
            print(paste("at iteration:", it))
            print(pop)
            objective1 = c()
            objective2 = c()
            for(j in (1:(popSize+1))){
                current = pop[j,]
                objective1[j] = evaluation(current, mat,1)
                objective2[j] = evaluation(current, mat,2)
            }
            print("x and y values")
            print(objective1)
            print(objective2)
            # reference point
            objective1[popSize+2] = 25
            objective2[popSize+2] = 5
            plot(x=objective1,y=objective2, main=paste("(with offspring) after ", it, " iterations (top right is the reference point)"))
        }

        # deciding the dominant indivuals
        dom = dominance(pop, mat)
        if(length(dom) == 0){
            # minimal S-metric contribution
            a = minSM(pop, refP)
        }else{
            # maximal dominace-value
            a = maxDom(dom)
        }
        if(it %% 10 == 0){
            print("deleting ")
            print(pop[a,])
        }
        # filtering for a
        pop = clean(pop, a)
        if(it %% 10 == 0){
            print("new population")
            print(pop)
            print("")
        }

        # storing the generation and incrementing the generation counter
        generations[[gen+1]] = pop
        gen = gen + 1
    }
    return(generations)
}
plotSMSEMOA <- function(ref, mat=HAP_II, popSize=3, maxIt=100){
    # running the algorithm
    results = SMSEMOA(ref, mat, popSize, maxIt)
    #print(results)
    for(i in (1:10)){
        objective1 = c()
        objective2 = c()
        current = as.matrix(results[[i*10]])
        for(j in (1:popSize)){
            objective1[j] = evaluation(current[j,], mat, 1)
            objective2[j] = evaluation(current[j,], mat, 2)
        }
        # reference point
        objective1[6] = 25
        objective2[6] = 5
        plot(x=objective1,y=objective2, main=paste("(without offspring) after ", i*10, " iterations (top right is the reference point)"))
    }
}



### questions / tasks
Q1 <- function(mat=HAP_I){
    plotAllSolutions(mat)
}
Q2 <- function(mat=HAP_II){
    plotAllSolutions(mat)
}
Q3 <- function(mat=HAP_II){
    plotEA11(mat, c(3))
}
Q4 <- function(mat=HAP_II){
    xVals = c()
    yVals = c()
    for(i in (1:nrow(SOL_NUMERIC))){
        xVals[i] = evaluation(SOL_NUMERIC[i,],mat,1)
        yVals[i] = evaluation(SOL_NUMERIC[i,],mat,2)
    }
    xVals[nrow(SOL_NUMERIC)+1] = 25
    yVals[nrow(SOL_NUMERIC)+1] = 5
    # validating and printing the values
    plot(x=xVals, y=yVals, main="All Solutions and reference point (points)",xlab="objective1", ylab="objective2")
    plot(x=xVals[(1:3)], y=yVals[(1:3)], main="All Solutions (stairs)",xlab="objective1", ylab="objective2", type="s")
}
Q5 <- function(){
    # worst for evalmethod1 = 25, worst for evalmethod2 = 5
    ref = c(25, 5)
    plotSMSEMOA(ref)
}

main <- function(){
    # Just uncomment for whatever plots you want
    #Q1()
    #Q2()
    #Q3()
    #Q4()
    Q5()
}



### function calls
main()
