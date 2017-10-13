#!usr/bin/bash/Rscript

table <- function(){
    t <- matrix(0,10,10)
    range <- seq(10)
    for(i in range){
        t[0][i] = i
    }
    s <- seq(10)
    for(i in range){
        s = range * i
        for(j in range){
            t[i,j] = s[j]
        }
    }
    return (t)
}
main <- function(){
    # multiplikation table
    m <- table()
    print(m[3,4])
    print(m[3,])
}
if(!interactive()){
    main()
}
