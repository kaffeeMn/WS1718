#############
### Aufgabe 4

# Bestimmen Sie für die Variablen Geschlecht, Größe und Therapie 
# den Wert einer geeigneten Kennzahl für die Lage

# Angabe des Pfades
setwd("C:/Joerg/teaching/Statistik_für_Informatiker_WS1718/Übungen1718")

# Laden des Datensatzes
load("Daten.RData")
Daten <- Datensatz

# Alternativ Einlesen der Text-Datei
Datensatz2 <- read.table("Daten.txt",header=T)

# 4a)

# Funktion zur Berechnung des Modalwertes
berechne.modus <- function(x){
  anzahl <- max(table(x))
  modus <- names(which.max(table(x)))
  list(Modus=modus, Anzahl=anzahl)
}

# Berechnung des Modus für die nominal skalierte Variable Geschlecht
table(Daten$Geschlecht)
berechne.modus(Daten$Geschlecht)

# Funktion zur Berechnung des (arithmetischem) Mittelwerts und des Medians
berechne.mittel <- function(x){
  x <- na.omit(x)
  Mittel <- mean(x)
  Median <- median(x)
  list(Mittel=Mittel, Median=Median)
}

# Berechne Mittelwert und Median für die stetige Variable Groesse
berechne.mittel(Daten$Groesse)

# Histogramm für die Variable Groesse
hist(Daten$Groesse,20)

# Berechnung des Modalwertes und des Medians für die ordinal skalierte Variable Therapie
# hier zum Vergleich direkt, ohne Funktion
# Median nur sinnvoll, wenn eine Ordnung unterstellt wird
table(Daten$Therapie)
(Modus <- as.numeric(names(which.max(table(Daten$Therapie)))))
median(Daten$Therapie)

# 4b)

# Klassieren der Variable Alter in Dekaden
# Mehrere Möglichkeiten, hier gewählt: 0-9 Jahre: 1. Dekade, 10-19 Jahre: 2. Dekade, usw.
Dekade <- floor(Daten$Alter/10) + 1
# Äquivalent:  Dekade <- Alter %/% 10 + 1

# Sortierte Werte
sort(Dekade)

table(Dekade)
## Dekade
##  1  2  3  4  5  6  7  8 
##  1 12 23 20  8 27  5  2 

# Berechnung der Ränge der Variable Dekade per Hand:
# Beachte 2 fehlende Werte
# Erster Wert kommt 1 mal vor: Rang 1
# Nächster Wert kommt 12 mal vor: Rang 2-13 wird gemittelt zu 7.5
# Nächster Wert kommt 23 mal vor: Rang 14-36 wird gemittelt zu 25
# ...
# Letzter Wert kommt zweimal vor: Rang 97-98 wird gemittelt zu 97.5

# Berechnung der Ränge der Variable Dekade in R
# Erster Ansatz:
rank(Dekade)
table(rank(Dekade))
# Vorsicht: Beobachtungen mit NA bekommt hierbei die Ränge 99 und 100 ! Deshalb:
table(rank(na.omit(Dekade)))

# 4c)

# Quartile für Alter und Groesse berechnen

# Allgemein über Funktion quantile in R (mit type=2)
quantile(Daten$Alter, c(0.25,0.75), na.rm=TRUE, type=2)
# 25% 75% 
#  23  52 

quantile(Daten$Groesse, c(0.25,0.75), na.rm=TRUE, type=2)
# 25% 75% 
#  75 80 


# Eigene Funktion zur Berechnung des unteren und oberen Quartils (Kap. 2, Folie 13)
quantile.fun <- function(x,p){
  x.sort <- sort(na.omit(x))
  j <- length(x)*p
  if (j == floor(j)){
    quant <- (x.sort[j]+ x.sort[j+1])/2
  } else {
    quant <- x.sort[ceiling(j)]
  }
  quant
}
  
quantile.fun(Daten$Alter, 0.25)
quantile.fun(Daten$Alter, 0.75)
quantile.fun(Daten$Groesse, 0.25)
quantile.fun(Daten$Groesse, 0.75)


#############
### Aufgabe 5

# Daten: 0, 0, -2, 2, 5
#
# 5a)
#
# Mittelwert: (0+0+(-2)+2+5)/5 = 5/5 = 1
# Median: Sortierte Daten: -2, 0, 0, 2, 5; Median: x(3) = 0
# Modalwert: 0 (einziger Wert, der doppelt vorkommt)
#
# 5b)
#
# Unteres Quartil: n*p = 5*0.25 = 1.25 nicht ganzzahlig
#  -> j=2: Q1 = x(2) = 0
# Oberes Quantil: n*p = 5*0.75 = 3.75 nicht ganzzahlig
#  -> j=4: Q3 = x(4) = 2
# 80%-Quantil: n*p = 5*0.8 = 4 ganzzahlig
#  -> Q_0.8 = (x(4)+x(5))/2 = (2+5)/2 = 3.5