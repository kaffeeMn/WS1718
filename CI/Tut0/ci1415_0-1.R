#!/usr/bin/Rscript

customSum <- function(a, b){
    return (a + b)
}
fibonaci <- function(n){
    if(n < 0){
        return (NULL)
    }else if(n == 0){
        return (0)
    }else{
        fib <- c(0,0,1)
        while(n > fib[3]){
            fib[1] = fib[2]
            fib[2] = fib[3]
            fib[3] = fib[1] + fib[2]
        }
        return (fib[3])
    }
}

main <- function(){
    # customSum testing addition of data types
    print(customSum(1,2))
    print(c(1,2,3,4), c(5,6))
    # smallest fibonaci number greater or equal to input
    print(fibonaci(5))
    print(fibonaci(6))
}
if(!interactive()){
    main()
}
