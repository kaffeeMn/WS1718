A = matrix(rep((1:10)),10,10)
print(t(A[,1]))
MultTable = A * t(A)
print(MultTable)

m <- function(a)
    return(a * c(1:10))

print(sapply((1:10),m))
