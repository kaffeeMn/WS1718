customSum <- function(x,y)
    return(x+y)

fibbonacci <- function(n){
    f0 <- 0
    f1 <- 1
    x  <- f0
    while(x<n){
        x  <- f0+f1
        f0 <- f1
        f1 <- x
    }
    return(x)
}
