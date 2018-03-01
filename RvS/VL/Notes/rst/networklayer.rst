Die Vermittlungsschicht
#######################

Router
======

Weiterleitung
-------------

Weitergabe eines Paketes vom Eingang eines Routers zum richtigen Aussgang.

Routing
-------

Bestimmung der Route vom Sender zum Empfaenger durch einen routing Algorithmus.

|

Virtueller Kanal ATM
====================

Virtueller Kanal kann genutzt werden, um vorab fuer eine Menge von Pakettransfers gemeinsame Recourcen zu reservieren.
Dabei soll eien Konfuguration folgende Probleme erleichtern

* Echtzeitgarantien
* Mindestdurchsatz
* verzoegerungszeit-Grenzen
* begrenzte Varitionen der Verzoegerungszeit

IP vs. Dienstklassen
--------------------

==============  =================== =================== =========== ==============  =================== ================
Architektur     Dienstmodell        Bandbreite          Verlust     Reihenfolge     Zeit                Ueberlasthinweis
==============  =================== =================== =========== ==============  =================== ================
Internet        best effort         keine Zusicherung   ja          bel.            nicht eingehalten   nein
ATM             CBR                 konstant            nein        eingehalten     eingehalten         keine Ueberlast
ATM             VBR                 garantiert          nein        eingehalten     eingehalten         keine Ueberlast
ATM             ABR                 garantiertes Min.   ja          eingehalten     nicht eingehalten   ja
ATM             UBR                 keine Zusicherung   ja          eingehalten     nicht eingehalten   nein
==============  =================== =================== =========== ==============  =================== ================

Virtual Circuit
---------------

VC-Nummern werden anstelle von Zieladressen verwendet. Router verwalten eine Tabelle mir Interface- und VC- Nummern.

e.g.:

=================== =============== =================== ===========
Eingangsinterface   Eingangs-VC     Ausgangsinterface   Ausgangs-VC
=================== =============== =================== ===========
1                   12              3                   22
2                   63              1                   18
(...)               (...)           (...)               (...)
=================== =============== =================== ===========

|

Datagramm
=========

Wenn wir das Internet als ein Datagramm-Netz betrachten moechten, muessen folgende Begebenheiten existieren.

* Jeges Paket muss seienn Weg durch das Netz finden koennen
    + Zieladresse
    + Pakete mit identischer Quell- und Zieladresse koennen unterschiedliche Wege waehlen
* Jeder Router auf dem Weg zum Ziel entscheidet, wohin das Paket weitergeleitet wird
    + Informationen ueber Netzstruktur und Netzzustand muessen erteilt werden

Die Loesung dieser Probleme sollen durch Routing Algorithmen geloest werden.

Netze
-----

Weiterleiten von Datagrammen

=========================================== =======
Zieladressbereich                           Ausgang
=========================================== =======
11001000 00010111 00010*** *********        0
11001000 00010111 00011000 *********        1
11001000 00010111 00011*** *********        2
sonst                                       3
=========================================== =======

|

Router
======

Ein Router hat zwei Hauptfunktionen 

1. Vermittlung von IP-Paketen und deren Weiterleitung
2. Pflege von Routingtabellen per PIP/OSPF/BGP

Aufbau
------

Router-Input-Ports leiten forwarding tables zum Routing-Processor (high-seed switching fabric) forwarding tables werden
dann durch die Router-Output-Ports weitergeleitet.

Eingang-Port
^^^^^^^^^^^^

3 Schichten:

1. line termination
    * Bituebertragung
2. link layer protocol
    * Protokoll der Sicherungsschicht
3. loppkup, forwarding (denzentralisiertes switching)
    * durch die Zieladrese wird der zugehoerige Ausgang aus der Routing-Tabelle gelesen
    * Ziel: Bearbeitung der 
