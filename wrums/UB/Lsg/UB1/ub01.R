main <- function(){
    dsetPaths <- c(
        "../../../data/UB1/Daten.txt", "../../../data/UB1/Daten.RData"
    )
    dset1 <- read.table(dsetPaths[1])
    dset2 <- load(dsetPaths[2])
}
if(!interactive()){
    main()
}
