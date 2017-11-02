#A4
## a)
getmode <- function(vec){
    return(names(sort(-table(vec)))[1])
}
eval_kl_data <- function(data){
    "
    pNr -> nominal
    thp -> ordinal
    gen -> nominal
    age -> quantitativ
    hei -> quantitativ
    we1 -> quantitativ
    bpr -> quantitativ
    smk -> nominal
    we2 -> quantitativ
    tme -> quantitativ
    idc -> nominal
    "
    pNr = data$PatientenNr
    thp = data$Therapie
    gen = data$Geschlecht
    age = data$Alter
    hei = data$Groesse
    we1 = data$Gewicht1
    bpr = data$Blutdruck
    smk = data$Raucherstatus
    we2 = data$Gewicht2
    tme = data$Zeit
    idc = data$Ereignisindikator
    
    results = list()
    results$pNr = getmode(pNr)
    results$thp = getmode(thp)
    results$gen = getmode(pNr)
    results$age = mean(age)
    results$hei = mean(hei)
    results$we1 = mean(we1)
    results$bpr = median(bpr)
    results$smk = getmode(smk)
    results$we2 = mean(we2)
    results$tme = mean(tme)
    results$idc = getmode(idc)

    return(results)
}
## b)
in_range <- function(min, max, x){
}
interval_groups <- function(data, interval){
    results = list()
    limit = max(data)
    n = 1
    while(limit > n*interval){
        results[[n]] = data[data<=n*interval]
        results[[n]] = results[[n]][results[[n]]>(n-1)*interval]
        n = n+1
    }
    results[[n]] = data[data<=n*interval]
    results[[n]] = results[[n]][results[[n]]>(n-1)*interval]
    return(results)
}
quantity_order <- function(lst){
    lens = matrix(0,1,length(lst))
    n = 1
    for(l in lst){
        lens[n] = length(lst[[n]])
        n = n+1
    }
    ords = matrix(0,1,length(lst))
    n = 1
    for(el in lens){
        ords[lens==max(lens)] = n
        lens[lens==max(lens)] = -1
        n=n+1
    }
    return(ords)
}
## c)
quartiles <- function(vals){
    results = list()
    quart = quantile(vals)
    results$lower = c(quart[2],quart[3])
    results$higher= c(quart[3],quart[4])
    return(results)
}
if(!interactive()){
    # A4
    print('A4')
    ## a)
    print('a)')
    klData = read.table('../../Daten.txt', sep=' ')
    klData = klData[complete.cases(klData),]
    avgPatient = eval_kl_data(klData)
    print(avgPatient)
    ## b)
    print('b)')
    ageCls = interval_groups(klData$Alter, 10)
    ageClsOrd = quantity_order(ageCls)
    print(ageCls)
    print(ageClsOrd)
    ## c)
    print('c)')
    quartsAge = quartiles(klData$Alter)
    quartsHei = quartiles(klData$Groesse)
    print(quartsAge)
    print(quartsHei)
}
