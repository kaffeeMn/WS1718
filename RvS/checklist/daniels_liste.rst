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

Leaky Bucket
============

Int-/ Diff Serv.
================

Firewalls
=========

Typen
-----

Screened Subnet Firewall
------------------------

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

Uni-, Multi-, Broadcast?
------------------------

Unicast -> nur mit einer person
Multicast -> mit einer Gruppe
Broadcast -> mit allen

verbindungslos vs. verbindungsorientiert?
-----------------------------------------

sim-, dup-, halbduplex?
-----------------------

simplez -> nur in eine richtung.

halbduplex -> in beide richtungen aber nicht zeitgleich

duplex -> in beide richtungen und zeitgleich

Kommunikationsfehler?
---------------------

Phantom, Manipulaition, Verlust

TCP, UDP?
---------

Paket-, Leitungsvermittlung?
-----------------------------

Multiplexing?
-------------

ISO/OSI Schichten?
-----------------

TCP/IP Schichten?
-----------------

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
