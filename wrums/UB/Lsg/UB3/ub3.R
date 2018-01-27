# helpful methods
#simps_d <- function(vec, norm=FALSE){
#    if(norm){
#        # D = J * (1 - (occurrences^2/ J^2) / (J-1)
#        return(length(vec) * (1 - (sum(table(vec)^2) / length(vec)^2)) / (length(vec)-1))
#    }
#    # D = 1 - (occurrences^2/ J^2)
#    return(1 - (sum(table(vec)^2) / length(vec)^2))
#}
simps_d <- function(vec, norm=T){
    J = length(table(vec))
    occurences = table(vec) 
    rel = occurences / length(vec)
    if(norm){
        # D = J * (1 - ()^2) / (J-1)
        return( J * (1-sum(rel^2)) / (J-1) )
    }
    # D = 
}
entropie <- function(){
}
therapy <- function(){}
quant_steuer_vl <- function(){}

# main method
if (getOption('run.main', default=TRUE)) {
    klData = read.table('../../Daten.txt', sep=' ')
    geschlecht = klData$Geschlecht
    groesse = klData$Groesse
    # therapy shall be ordinal
    therapy = klData$Therapie
    print(simps_d(geschlecht))
    print(entropie(geschlecht))
    print(letis_d(therapy))
    print(quant_steuer_vl(groesse))
}
