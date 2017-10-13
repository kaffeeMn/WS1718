#!/usr/bin/Rscript

mean <- function(s){
    sum = 0
    for(i in s){
        sum = sum + i
    }
    return (sum/length(s))
}
median <- function(s){
    l = sort(s)
    return (l[length(l)/2])
}
minimal <- function(s){
    min = s[1]
    for(i in s){
        if(i<min){
            min = i
        }
    }
    return (min)
}
maximal <- function(s){
    max = s[1]
    for(i in s){
        if(i>max){
            max = i
        }
    }
    return (max)
}
main <- function(){
    t <- read.csv("iris.data")
    data = t["petalLength"]
    print(sd(data[,1]))
}
if(!interactive()){
    main()
}
