###################
Internet‐Pruefsumme
###################

PruefSummen
-----------

Verfahren
=========

1. Benachbarte Octets, die in die Pruefsumme eingehen, werden paarweise zu 16 Bit Integer zusemmengefuegt. Bei einer
   ungeraden Anzahl von Octets wird ein Null-Octet hinzugefuegt
2. Die Pruefsumme selbst ist mit Nullen gefuellt
3. Die 16 Bit Einerkomplement-Summe aller 16 Bit Woerter wird berechnet un deren Einerkomplement in das PruefsummenFeld
   geschrieben.
4. Um die Pruefsumme zu ueberpruefen wird die 16 Bit Einerkomplement-Summe ueber dieselben Octets berechnet. Wenn alle
   Stellen des Ergebnisses 1 sind ist die Pruefung erfolgreich
