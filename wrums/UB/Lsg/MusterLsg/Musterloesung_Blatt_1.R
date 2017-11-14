# Aufgabe 1
# ---------
# 
# a)
#
# Herstellungsdatum: Stetig (Intervallskala)
# Prozessor: Nominal
# Prozessornummer: Nominal (auch innerhalb von Untergruppen ordinal möglich)
# Gewicht: Stetig (Verhältnisskala)
# Taktfrequenz: Stetig (Verhältnisskala)
# Anzahl der Prozessorkerne: Diskret (Verhältnisskala)
# Cachegröße: Stetig (Verhältnisskala)
# Bildschirmdiagonale: Stetig (Verhältnisskala)
# Auflösung: Bivariates Merkmal (kann nicht einmal geordnet werden!),
#   für beide einzelne Komponenten gilt: Stetig (Verhältnisskala)

# b)
#
# Name: Nominal
# Geburtsdatum: Stetig (Intervallskala)
# Alter: Stetig (Intervallskala) (auch diskret möglich)
# Geschlecht: Nominal
# Augenfarbe: Nominal
# Blutgruppe: Nominal
# Gewicht: Stetig (Verhältnisskala)
# Größe: Stetig (Verhältnisskala)
# Bewertung des Gesundheitszustands (1-10): Ordinal
# Körpertemperatur: Stetig (Verhältnisskala)



# Aufgabe 3
# ---------

# a)

# Patientennummer, Therapie, Geschlecht, Raucherstatus, Ereignisindikator: Nominal
# Alter, Größe, Gewicht1, Gewicht2, Blutdruck, Überlebenszeit: Stetig (Verhältnisskala)

# b)

# Angabe des Pfades
setwd("C:/Joerg/teaching/Statistik_für_Informatiker_WS1718/Übungen1718")

# Laden der Daten aus einer .RData-Datei
load("Daten.RData")

# Objekte im Verzeichnis
ls()

# Übersicht über den Datensatz
str(Datensatz)

# Laden der Daten aus einer Text-Datei
Datensatz2 <- read.table("Daten.txt",header=T)
str(Datensatz2)

# Auswählen der Patienten ohne fehlende Beobachtungen
select <- which(rowSums(is.na(Datensatz))>0|Datensatz$Raucherstatus==".")
Daten <- Datensatz[-select,]

# Direkter Zugriff auf Variablen
attach(Daten)

# Wir betrachten zuerst nur die ausgewählten Patienten

# Absolute Häufigkeiten (univariat)
table(Therapie)

# Therapie
#  1  2  3 
# 30 29 33 

# Relative Häufigkeiten (univariat), gerundet auf 2 Stellen
round(table(Therapie)/length(Therapie),2)

# Therapie
#    1    2    3 
# 0.33 0.32 0.36 

# Stabdiagramm
barplot(table(Therapie), main="Absolute Häufigkeiten Therapie")

# Betrachtet man alle Patienten, so erhält man

table(Datensatz$Therapie)

#  1  2  3 
# 32 31 37 

# c)

# Plotten der empirischen Verteilungsfunktion für die Variable Blutdruck
plot.ecdf(Blutdruck)

# Plotten der empirischen Verteilungsfunktion, getrennt für Raucherstatus
par(mfrow=c(2,1))
plot.ecdf(Blutdruck[Raucherstatus=="ja"],xlim=c(80,240),main="Raucher")
plot.ecdf(Blutdruck[Raucherstatus=="nein"],xlim=c(80,240),main="Nichtraucher")

# d)

# Histogramm für die Größe der Patienten,
# mit gefragter Einteilung und mit automatischer Einteilung
par(mfrow=c(2,1))
hist(Groesse,breaks=c(120,180,200),freq=FALSE)
hist(Groesse,freq=FALSE)

# e)

# Histogramme für Gewicht 1
par(mfrow=c(3,1))
hist(Gewicht1,breaks=20,xlim=c(0,120))
hist(Gewicht1,breaks=100,xlim=c(0,120))
hist(Gewicht1,breaks=5,xlim=c(0,120))
# 20 Klassen für grobe Information geeignet,
# 100 für detaillierte Information geeignet,
# 5 Klassen eher zu wenig
