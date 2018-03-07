#############
### Aufgabe 6

# 6a)


# Laden des Datensatzes
load("../../Daten.RData")
Daten <- Datensatz

# Funktion zur Berechnung der Kennzahlen Simpson's D und Entropie (Kap.2, Folie 29 und 35)
simpsons.D <- function(x){
  J <- length(table(x))
  rel.h <- table(x)/length(x)
  simpsons.D <- (1-sum(rel.h^2)) * J / (J-1)
  simpsons.D
}

entropie <- function(x){
  J <- length(table(x))
  rel.h <- table(x)/length(x)
  entropie <- -sum( rel.h * log2(rel.h) / log2(J) ) 
  entropie
}

simpsons.D(Daten$Geschlecht)
# [1] 0.96

entropie(Daten$Geschlecht)
# [1] 0.9709506


# Simpson's D per Hand berechnen:
#
# Geschlecht:
#   J=2
#   rel.Häufigkeiten: 0.6, 0.4
#
# D = 2/1*(1-0.6*0.6-0.4*0.4) = 2*(1-0.36-0.16) = 2*0.48 = 0.96


# 6b)

## Funktion zur Berechnung der Kennzahl Leti's D (Kap. 2, Folie 41)
Letis.D <- function(x){
  x <- na.omit(x)
  fn <- table(x)/length(x)    # fn =rel.h relative Häufigkeiten
  Fn <- cumsum(fn)
  J <- length(fn)
  Letis.D <- 4 / (J-1) * sum(Fn*(1-Fn))
  Letis.D
}

# Berechnung mit der R-Funktion
Letis.D(Daten$Therapie)
# [1] 0.9014


# Berechnung "per Hand"
# J-1 = 2,
# f1 = 32/100, f2 = 31/100, f3 = 37/100
# F1 = 32/100, F2 = 63/100, F3 = 100/100 = 1
# Leti = 4 / (J-1) * ( F1*(1-F1) + F2*(1-F2) )
# Leti = 4 / 2 * ( 32/100*68/100 + 63/100*37/100 ) = 0.9014

# 6c)

# Berechnung von Streuungmaßen für die stetige Variable Groesse
x <- na.omit(Datensatz$Groesse)

# Übersicht über die Variable Groesse
summary(x)
hist(x, 20)

# MAD / Spannweite / Quartilsdifferenz
mad(x)
diff(range(x))
# Äquivalent: max(x)-min(x)
IQR(x,type=2)
# Äquivalent: diff(quantile(x, c(0.25,0.75), type=2))

# Varianz / Standardabweichung / Variationskoeffizient
var(x)
sd(x)
sd(x)/mean(x)

