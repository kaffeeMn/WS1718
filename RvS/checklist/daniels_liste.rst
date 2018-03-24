################
Liste Der Fragen
################

Primaere Fragen
###############

Sockets Methoden?
=================

TCP
---

=================================== =======================================
Server                              Client
=================================== =======================================
socket()                            socket()
bind()                              connect()
listen()                            send()
accept()                            revc()
send()                              close()
revc()
close()
=================================== =======================================

======================================= ===================================
Server                                  Client                             
======================================= ===================================
serverSocket = socket()                 clientSocket = socket()
connectionSkt = serverSocket.accept()   
requ = connectionSkt.revc()             clientSocket.send(requ)
connectionSkt.send(reply)               reply = clientSocket.revc()
connectionSkt.close()                   clientSocket.close()
======================================= ===================================

UDP
---

=================================== =======================================
Server                              Client
=================================== =======================================
socket()                            socket()
bind()                              sendto()
sendto()                            revcfrom()
revcfrom()                          ( bind() )
=================================== =======================================

======================================= ===================================
Server                                  Client                             
======================================= ===================================
serverSocket = socket()                 clientSocket = socket()            
adress = socket.revcfrom()              clientSocket.sendto(hostId, port=x)
serverSocket.sendto(adress)             data = clientSocket.revcfrom()     
                                        clientSocket.close()
======================================= ===================================

IP Adresszuteilung?
===================

x.x.x.x/n mit n als masken bits

Paradigma
=========

Client-Server
-------------

Client initiert Kontakt mit dem Server, fordert einen Dienst vom Server an

Server bietet dem Client eine Dienstleistung an

Peer-to-Peer
------------

Gleichberechtigte Peers

+ keine zentrale Funktion benoetigt
- verwaltung von vielen Peer-Peer Assoziationen 

Peers wirken fuer andere Peers als Server und umgekehrt.

MAC?
====

Media Access Control

Leitungsarten:

* Point-to-Point links
* geschaltete link (switched links)
* Sammelleitungen/ Busse/ Mehrfachzugriffsmedien

CSMA
----

Carier Sense Multiple Access

Prinzip ist es erst zu hoeren ob jemand schon sendet bevor man sendet

CSMA CD
-------

Hoeren ob jemand anderes schon sendet bevor man selbst sendet.
Auch waehrend dem Senden lauschen, ob jemand dazwischen funkt.

Bei collision: exponential backoff algorithm


CSMA CA
-------

* rts/ cts

Aloha
-----

Senden bei Sendewunsch und ohne abstimmung.
Was ankommt kommt an, sonst halt nicht.

Paket ist waehrend der gesamten Sendezeit verletzlich.

Slotted Aloha
^^^^^^^^^^^^^

Verbesserung von Aloha, bei der ein Zeitraster in slots unterteilt wird.
Bei Sendewunsch wird zu beginn des naechsten slots gesendet.

Sonst wie aloha, nur dass die Pakete weniger oft kollidiert.

Polling
-------

"Busmaster" fragt hintereinander die anderen am Bus ab, ob sie senden moechten.

Der Knoten antwortet mit ein poll- oder einer responsemessage

Nachteile:
* Polling Overhead
* Wartezeit
* Wenn die Zentrale aussfaellt, faellt das gesamte System aus

Token Ring
----------

Wer das Token hat und senden moechte sendet und gibt dann das token weiter. Wer nicht senden moechte gibt es direkt weiter.

die weitergabe erfolgt zyklisch

Problem:
* Overhead durch kreisendes Token
* wartezeit, bis der Sender wieder an der Reihe ist
* bei einem verlorenem Token steht das System

ARP/ Mac Adresse
----------------

MAC Adressen fuer lan-interne adressierung, token etc..

Im Adress Resolution Protokoll werden ip adressen zu mac adressen zugeordnet.
Die im ARP-Cache gespeicherten Adressen werden nach 20 min. wieder geloescht.

Falls MAC-Adresse gesucht wird, wird zunaechst ein Broadcast mit der IP-adresse gesendet. Derjenige
mit der zugehoerigen IP-Adresse antwortet "IP hat diese MAC Adresse"

Leaky Bucket
============

Leaky Bucket ist eine Policing-Massnahme
Eine mittlere Senderate, Spitzenrate und maximale Burstgroesse soll vestgehalten werden.

Der leaky Bucket haelt eine feste Anzahl von Token. 

Er behandelt Jitter (Verzoegerungsschwankungen)

Int-/ Diff Serv.
================

Int
---

* Markiert nur in zwei klassen (audio und video). 
* Kann Bandbreite reservieren
    + grundlegende Aenderung im Internet, software fuer Router und Hosts

Diff
----

* wenige Aenderungen im Internet
* Komplexe Funktionen nur am Rand
* bevorzugung durch in und out profile
* in profile Pakete werden vrogezogen
* eine garantierte weiterleitung existiert


Firewalls
=========

Typen
-----

Filtertypern sind

Verbindungs(Transport)-, Applikations(Anwendungs)- und Paketfilter

Screening Router
^^^^^^^^^^^^^^^^

Router mit Paketfilterfunktionen

Bastion Host
^^^^^^^^^^^^

Host mit Anwendungs- und Verbindungsfiltern

Dual Homed Bastion Host
^^^^^^^^^^^^^^^^^^^^^^^

Host mit Anwendungs- und Verbindungsfilter und 2 Netzinterfaces

Screened Subnet Firewall
------------------------

Die Screened Subnet Firewall verbindet Screening Router mit Dual Bastion Hosts.

Ein Screening Router der vorab das spoofing, danach kommen die Bastion Hosts, dann
der zweite Screening Router, der erzwingt, dass der Verkehr nur ueber die Bastion 
Hosts stattfindet.

verteilte Algorithmen
=====================

Atommodell
----------

Lokale Abhaengigkeit
--------------------

Sekundaere Fragen
#################

Was ist ein verteiltes System?
------------------------------

System, dessen Komponenten sich an verschiedenen Orten befinden

Uni-, Multi-, Broadcast?
------------------------

Unicast -> nur mit einer person
Multicast -> mit einer Gruppe
Broadcast -> mit allen

verbindungslos vs. verbindungsorientiert?
-----------------------------------------

Datagramme sind verbindungslos. (UDP, unzuverlaessig)

TCP ist verbindungsorientiert und zuverlaessig.

sim-, dup-, halbduplex?
-----------------------

simplez -> nur in eine richtung.

halbduplex -> in beide richtungen aber nicht zeitgleich

duplex -> in beide richtungen und zeitgleich

Kommunikationsfehler?
---------------------

Phantom, Manipulaition, Verlust

TCP, UDP
--------

TCP
splittet daten in subpakete mit sequenznummern auf.

UDP 
sendet daten als datagramm

Paket-, Leitungsvermittlung?
-----------------------------

Multiplexing?
-------------

ISO/OSI Schichten?
-----------------

1. application
2. darstellung/ presentation
3. kommunikation/ session
4. transport
5. network
6. link
7. physical

TCP/IP Schichten?
-----------------

1. Anwendung/ application
2. Transport
3. Vermittlung/ network
4. Sicherung/ link
5. physical

Protokolle fuer einzelne Schichten?
-----------------------------------

Pruefsummen
-----------

IP v4/ v6 (Dual stack und tunneling)
------------------------------------

Streaming Protokolle
--------------------

QoS (Dienstgueterparameter/ Garantien)
--------------------------------------

Sicherheitsziele
----------------
