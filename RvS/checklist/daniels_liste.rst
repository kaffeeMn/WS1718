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

CSMA CD
-------

CSMA CA
-------

Aloha
-----

Polling
-------

Token Ring
----------

ARP/ Mac Adresse
----------------

Bucket
======

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

verbindungslos vs. verbindungsorientiert?
-----------------------------------------

sim-, dup-, halbduplex?
-----------------------

Kommunikationsfehler?
---------------------

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
