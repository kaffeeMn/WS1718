Die Sicherungsschicht
#####################

Table of Contents
#################

Skript
######

Verfaelschungserkennung
=======================

Prinzip
-------

Abbildung von Daten auf erweiterte Daten. Die dabei entstehende Redundanz wird benutzt um Verfaelschungen zu erkennen.

Verfahen
--------

Parity
^^^^^^

Erkennung eines 1-Bit-Fehlers:

0001 0000 haette das Parity bit 1, da die anzahl an einsen ungerade ist.

|

In zwei dimensionalen Arrays liefe dies wie folgt ab

+---------------------+-------------------------+-------------------+
|                     | array                   | parity bit row    |
+=====================+=========================+===================+
|                     | 10101                   | 1                 | 
+---------------------+-------------------------+-------------------+
|                     | 11110                   | 0                 | 
+---------------------+-------------------------+-------------------+
|                     | 01110                   | 1                 | 
+---------------------+-------------------------+-------------------+
| parity bit column   | 00101                   |                   |
+---------------------+-------------------------+-------------------+

Ein Fehler kann ueber die Tabelle im 2. array erkannt werden.

Internet Pruefsumme
^^^^^^^^^^^^^^^^^^^

Sender

* Interpretiert jedes Segment als Sequenz von 16-Bit Zahlen
* Pruefsumme ist die 1er-Komplementsumme des Segmentinhalts
* Sender schreibt die Pruefsumme in das entsprechende Feld

Empfaenger

* Berechnet die Pruefsumme des empfangenen Segments
* Vergleicht die berechnete Pruefsumme mit dem Wert im Pruefsummenfeld

CRC
^^^

Cycle Redundancy Check

Ein DatenPaket D wird als Binaerzahl gesehen, eine Binaerzahl liegt als Generatorzahl G fest.

Ziel:

.. math::

    R = rest( (2^r * D) / G )\\
    E = <D,R> \% G = 0

e.g.:

.. math::

    D = 1101011011, G = 10011\\
    2^{r+1}*D = 2^4*D = 11010110110000\\
    R = 1110

FEC
^^^
Forward Error Correction

|

FEC wendet Hamming-Code an.
Grundidee bei Hamming-Code ist:

Bitstring D der Laenge m, hat r Redundanzbits, die mitgeschickt werden muessen

Hamming- Distanz d eines Codes:

kleinste anzahl von Bits in welchen sich zwei Elemente des Codes unterscheiden.

Hamming Verfahren:

1. Betrachte das Quellzeichenformat D und berechne r
2. Ordne die Check-Bits in D so ein, dass die Positionsnummer die Check-Bits genau eine 1 in der Binaerdarstellung haben.
   (0..1, ... , 1..0)
3. Berechne die Check-Bits sukzessiv:
   Fuer das Check-Bit an der Position 2^i werden alle Positionen des Code Strings betrachtet, in denen die i-te Komponente
   der Positionsnummer 1 ist.
4. Zaehle die unter diesen Positionen im Code-String auftetenden Einsen
5. Ergaenze zur geraden Paritaet
6. Der Code-String wird gesendet. Auf der Empfaengerseite werden die Check-Bits daufhin geprueft, ob die Paritaet stimmt.
    * Wenn Ja: Akzeptiere das Code-Wort
    * Wenn Nein: 
        + ein falsches Check-Bit: Das Checkbit selbst ist falsch
        + mehr als ein Check-Bit ist falsch: Das Datenbit ist falsch 

|

MAC
===

Media Access Control

Ideale Loesung
--------------

.. todo ab Kap 4 Folie 24

|

Aloha
=====

|

LAN
===

|

ARP
===

|

Ethernet
========

|

Hubs
====

|

Bruecken
========

|

Switches
========

|

VLAN
====

|

WLAN
====

|

PPP
===
