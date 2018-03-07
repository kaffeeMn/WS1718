library('fclust')

load(file="clusterData")

# does not accept k=1, hence we incremented to 2
j=1
d1L = c()
d2L = c()
d3L = c()
for(i in (2:5)){
    #dat1_fkm = FKM(dat1, k=i, m=3, maxit=50)
    dat2_fkm = FKM(dat2, k=i, m=3, maxit=50)
    #dat3_fkm = FKM(dat3, k=i, m=3, maxit=50)
    #plot(dat1_fkm)
    plot(dat2_fkm)
    #plot(dat3_fkm)
    #d1L[j] = PE(dat1_fkm$U,2)
    d2L[j] = PC(dat2_fkm$U)
    #d3L[j] = PE(dat3_fkm$U,2)
    j = j + 1
}
#print(d1L)
print(d2L)
#print(d3L)
