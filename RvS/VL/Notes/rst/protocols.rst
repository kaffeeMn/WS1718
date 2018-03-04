Zusammenfassung Der Protokolle
##############################

Table of Contents
#################

* TCP_
* UDP_
* Mail_Protokolle_
* Pipeline_Protokolle_
* IP_

Skript
######

.. _TCP:

TCP
===

Transmission Control Protocol

Ziel
----

"Verbindungsorientierter" Datentransfer zwischen Endsystemen

Charakterisitker
----------------

* Zuverlaessiger Datentransfer
* Flusskontrolle
* Ueberlastungskontrolle
* kein Timing
* keine garantierte Bandbreite

Funktionsweise
--------------

* tcp_transport_

Anwendungsbeispiele
-------------------

* E-Mail
* remote terminal access
* WWW
* Dateitransfer
* streaming

|

.. _UDP:

UDP
===

User Datagram Protocol

Charakterisitker
----------------

* Unzuverlaessiger Datentransfer
* keine Flusskontrolle
* keine Ueberlastkontrolle
* Pakete koennen verloren gehen
* kein Timing
* keine garantierte Bandbreite

Ziel
----

"Verbindungsloser" Datentransfer zwischen Endsystemen


Funktionsweise
--------------

1:1 Weitergabe der IP-Pakete mit wenig Overhead (einfaches Protokoll)

* udp_transport_

Header:
^^^^^^^
* Quellportnummer
* Zielportnummer
* Laenge
* Pruefsumme

Anwendungsbeispiele
-------------------

* streaming
* telefonie

|

FTP
===

File Transfer Protokol

Ziel
----

Uebertragung einer Datei von/ zu einem entfernten Rechner.

Charakterisitker
----------------

* Sicherheitsprobleme
* Bei Anmeldung werden Nutzername und Passwort als Klartext uebertragen
* Dateien auch unverschluesselt

Funktionsweise
--------------

* benutzt das Client/ Server - Modell
* wegen Sicherheitsproblemen eher fuers Intranet geeignet
* besser waere SFTP

Client und Server komunizieren wie folgt:

1. Client ruft Server Ueber Port 21 auf und spezifiziert TCP als TransferProtokoll
2. Client autorisiert sich ueber die Kontrollverbindung
3. Der Client kann sich die Verzeichnisse ders Serves mittels der Kontrollkommandos ansehen
4. Dateitransfer fuehrt zur Oeffnung einer TCP-Verbindung
5. Nach dem Transfer wird diese Verbingung geschlossen
6. Server oefnet eine neue Verbindung zur Uebertragung der naechsten Datei
7. Server speichert den Zustand des Client
8. FTP sendet Kontrollinformationen seperat

|

.. _Mail_Protokolle:

SMTP (E-Mail)
=============

Simple Mail Transfer Protocol

Ziel
----

Charakterisitker
----------------

Funktionsweise
--------------

SMTP nutzt TCP um E-Mails vom Sender zum Empfaenger Server zu senden.

Eine Nachricht besteht aus einem Umschlag(Envelope) und einem Inhalt(Body)

3 Phasen
^^^^^^^^

1. Handshake
2. Transfer
3. Beenden der Verbindung

MIME
^^^^

Multipurpose Internet Mail Extension

kodierte Dateien koennen nicht direkt per Mail verschickt werden, da sie nicht ASCII kodiert sind

MIME fuegt einen MIME-Header beim Sender hinzu, der Empfaenger interpretiert diesen Header und dekodiert den ASCII-Text
in das im header angegebene Format.

|

POP(3)
======

Post Office Protocol

Funktionsweise
--------------

Simpel

3 Phasen
^^^^^^^^

1. Authentifizierung
2. Transaktion
3. Update

IMAP
====

Internet Mail Access Protocol

Funktionsweise
--------------

komplexer als POP

erlaubt verwalten von Ordnern auf Serverseite, auslesen von Mail-Headern, suchen von Nachrichten

|

.. _udp_transport:

UDP PDU-Format
==============

Header
------

* Quellportnummer
* Zielprtnummer
* Laenge
* Pruefsumme

Pruefsummen
-----------

Pruefsummen werden fuer udp_transport_ und tcp_transport_ gleich berechnet.

Siehe das `Pruefsummen Dokument <../html/pruefsummen.html>`_

|

Sicherer Transfer Durch Transferdienste
=======================================

Bei Datentransfer koennen Fehler Auftreten.
Um sicherzustellen, dass trotzdem Daten richtig versendet werden wurden Dienste wie `rdt <../html/dienste.html>`_ 
eingefuehrt.

|

.. _Pipeline_Protokolle:

Pipeline Protokolle
===================

Motivation
----------

rdt ist zu langsam/ ineffizient. Eine Moeglichkeit, den Datentransfer zu beschleunigen ist es Pakete schon zu uebertragen
bevor ACK eintrifft. 

Dabei werden Pakete gespeichert, deshalb nur Pakete in einem Kreditrahmen von Sequenznummern.

Ablauf
------

* Laufnummmern(Sequenznummern) im Fenster sind wiederkeherend/ wiedervernwendet

Go back n
^^^^^^^^^

Sender:

* K-bit Sequenznummer im Paket-Header
* es gibt ein "Sende-Fenster" von bis zu N nicht bestaetigten Nachrichten die versendet werden duerfen
* ein ACK zum Paket n bestaetigt das Paket n und alle Pakete, die zuvor gesendet wurden
* ein Timer/ Wecker laeuft jeweils fuer das aelteste Paket, dass noch nicht bestaetigt wurde
* Beim Ablauf des Timers/ Weckers werden alle noch nicht bestaetigten Pakete erneut gesendet

|

Empfaenger:


* ACK fuer das korrekt empfangene Paket mit der groessten Sequenznummer senden
* Empfangen von Paketen in falscher Reihenfolge fuehrt zum wegwerfen dieser Pakete und dem Senden von ACK
  fuer das letzte Paket das korrekt in richtiger Reihenfolge empfangen wurde

Selective Repeat
^^^^^^^^^^^^^^^^

Sender:

* sendet nur unbestaetigte Pakete erneut
* setzt einen Timer fuer jedes Paket
* sendet Paket wenn naechste Sequenznummer im Fenster liegt
* sendet bei Timeout Paket erneut
* markiert bestaetigte Pakete
* verschiebt das Fenster, wenn das Paket mit der kleinsten Paketnummer bestaetigt wurde

|

Empfaenger:

* bestaetigt jedes korrekt empfangene Paket
* puffert Pakete, die in falscher Reihenfolge empfangen wurden
* liefert Pakete aus, die in richtiger Reihenfolge empfangen wurden.

|

Ein Problem kommt auf, wenn alle N ACKS verloren gehen. Da dann ein packet doppelt akzeptiert wird, an falscher Stelle.

|

Mechanismen - Zusammenfassung
=============================

================================    =========================================================
Mechanismus                         Funktion
================================    =========================================================
Pruefsumme                          Fehlererkennung
Timer                               Verluste erkennen (doppelte uebertragung moeglich)
Sequenznummern                      Lucken im Paketstrom und doppelte uebertragungen erkennen
ACKs                                Bestaetigung kottekter Empfang
NAKs                                Bestaetigung nicht korrrekter Empfang
Fenster, Pipelining                 Effizienzsteigerung und Flusskontrolle
================================    =========================================================


|

.. _tcp_transport:

TCP PDU-Format
==============

Header
------

Komponenten
^^^^^^^^^^^

* Source Port
* Destination Port
* Sequence Number
* ACK-Number
* Header Length
* Optionale zusaetzliche Kontrollinformationen
* Receive Window (Zeitfenster???)

* Flags indizieren wann die obigigen Komponenten gueltig sind
    + U: Urg data pointer gestzt
    + A: ACK gesetzt
    + P: Dateb sofort an die Anwendungsschicht weiterreichen
    + S: Sequenznummer???
    + F: ???

|

TCP Timeout
===========

Problem:

Ist das Timeout zu klein entstehen unnoetige Wiederholungen, ist es zu gross wird zu lange gewartet.

Man muss also ein Timeout waehlen, dass maginal groesser als die RTT ist.

RTT schaetzen
-------------

SampleRTT:
^^^^^^^^^^

* Zeitspanne eines Semgments bis zum Empfang des ACKS (Wiederholungen nicht beruecksichtigt)
* Problem: aendert sich bei jedem Paket

EstimatedRTT:
^^^^^^^^^^^^^

.. math::
    
    EstimatedRTT \coloneqq ( 1 - \alpha ) \cdot EstimatedRTT + \alpha \cdot SampleRTT

* Exponentiell gewichteter Durchschnitt: Einfluss alter Messungen faellt exponentiell
* typisher alpha wert: 0.125

ACKS
----

===================================================         ==========================================================
Ereigniss Empfaenger                                        Aktion Empfaenger
===================================================         ==========================================================
erhalte Seq.Nr. vorherigen Daten bestaetigt                 warte 500ms auf neues Segment, sonst sende ACK
erhalte Seq.Nr. vorherigen Daten nicht bestaetigt           bestaetige unbestaetigte Segmente
erhalte zu grosse Seq.Nr. (Luecke entdeckt)                 sende "duplicate ACK" mit der naechsten erwarteten Seq.Nr.
erhalte Seq.Nr. die eine Luecke fuellt                      wenn Segment zu beginn der Luecke startet sende ACK
===================================================         ==========================================================

|

TCP fast retransmit
===================

fast retransmit ist eine weitere Regel fuer den Sender:

Wenn der Sender 3 ACKs fuer das selbe Segment erhaelt, sendet er das danach nachfolgende Segment noch einmal, sogar schon
vor dem Ablaufen des Timers.

Dadurch wird die Zeit bis zum neuem Senden des Segments verringert.
Inspiriert durch das senden von "duplicate ACK"

|

TCP FLusskontrolle
==================

Zur optimierung des Prozesses sollten Sende- und Leserate moeglichst nahe beieinander liegen.

Bei der Flusskontrolle sendet der Empfaenger beim jedem Segment den Wert des Fensters mit

Fuer den Sender gilt das Gleichgewicht:

.. math::

    LastByteSent - LastByteAcked \leq WindowSize

|

TCP Verbindungsverwaltung
=========================


Verbindungsaufbau
-----------------

TCP Sender und Empfaenger muessen erst eine Verbingung etablieren, bevor sie Daten Austauschen.
Typischer Weise passiert soetwas ueber einen `3 Wege Handshake <../html/handshake.html>`_ 

1. Initialisiere die TCP Variablen:
    * Sequenznummern
    * buffers
    * flow control info (e.g. RcvWindow)
2. Client initiert die Verbindung
    * Socket clientSkt = new Socket("hostname", portNumber);
3. Server wird vom Client kontaktiert
    * Socket connectionSocket = welcomeSocket.accept();

Schliessen einer Verbindung
---------------------------

Socket.close();

1. Client sender TCP FIN - Kontrollsegment an Server
2. Server empfaengt FIN, sendet ACK, beendet die Verbindung und sendet FIN simultan.
3. Client empfaengt FIN sendet ACK geht in warte zustand
4. Server empfaengt ACK, Verbindung beendet.

|

TCP Client
==========

Ablauf
------

1. CLOSED       -> sendSYN (initiert Verbindung)
2. SYN_SEND     -> receiveSYN && ACK then sendACK
3. ESTABLISHED  -> Datentransfer, bis Transfer abgeschlossen ist
4. ESTABLISHED  -> sendFIN
5. FIN_WAIT_1   -> receiveACK then sendNothing
6. FIN_WAIT_2   -> receiveFIN then sendACK
7. TIME_WAIT    -> wait30sec
8. start at 1

|

TCP Server
==========

1. CLOSED       -> initiere Empfangssocket
2. LISTEN       -> receiveSYN then sendSYN; sendACK
3. SYN_RCVD     -> receiveACK then sendNothing
4. ESTABLISHED  -> Datentransfer, bis Transfer abgeschlossen ist
5. ESTABLISHED  -> receiveFIN then sendACK
6. CLOSE_WAIT   -> sendFIN
7. LAST_ACK     -> receiveACK then sendNothing
8. start at 1

|


TCP Ueberlastungskontrolle
==========================

Die Ueberlastungskontrolle wurd im `Dokument zu Ueberlastungskontrolle <../html/ueberlastungskontrolle.html>`_ abgehandelt.

Im folgenden wird die Ueberlastungskontrolle in TCP erlaeutert.
TCP verwendet eine Ende zu Ende Ueberlastungskontrolle.

Es gilt:

.. math::

    w = LastByteSent - LastByteAcked\\
    \\
    w \leq^! \ Sendefenstergroesse_{aktuell}\\


ein Sender darf nur dann ein neues Paket senden, wenn die Fenstergroesse noch nicht erschoeft ist.
Die aktuelle Sendefenstergroesse wird als Minimum aus 2 Werten bestimmt

.. math::

    RcvWin =^{def} \ \text{der den Empfaenger zugeteilte Kredit}\\
    ConWin =^{def} \ \text{vom Sender emsprechend des Stau-mechanismus bestimmt}\\
    \\
    Sendefenstergroesse = min(RcvWin, ConWin)\\

Algorithmus
-----------

Ziel ist es Ueberlast zu vermeiden und im Fall einer Ueberlast, diese moeglichst gering zu halten.

1. Grenzwert setzen. Anfangs auf ein MSS, danach bei jeder Bestaetigung um ein MSS erhoehen. Die Fenstergroesse (CongWin)
   muss aber unterhalb eines Thresholds liegen.
2. (bei Threshold ueberschreitung) wenn bei der Inkrementierung um ein MSS der Threshold ueberschritten wird, 
   wird nur noch um MSS/CongWin erhoeht.
3. (bei Timeout) wenn ein Timeout erfolgt wird der Threshold auf die haelfte von CongWin gesetzt und CongWin auf 1 gesetzt
   fortfahren bei 1.

Der Schritt 1 leitet eine exponentielle Wachstumsphase ein, Ab dem Threshold folgt eine fast liniare Wachstumsphase mit 2.

|

Fairness
========

Ziel
----

Wenn K TCP-Verbindungen eine Leitung mit der Kapazitaet R teilen, die zum Flaschenhalt wird, sollte jede Verbindung eine
Kapazitaet von ugefaehr R/K erhalten.


TCP vs UDP
----------

+-------------------------------------------------------+------------------------------------------------------------+
| TCP                                                   | UDP                                                        |
+=======================================================+============================================================+
| Anwendung kann mehrere TCP-Verbindungen gleichzeitig  |   Anwendungen nutzen oft UDP                               |
+-------------------------------------------------------+------------------------------------------------------------+
| Kapazitaet R, 9 Verbind. neue Anwendung erhaelt mehr, |   UDP erlaubt es beliebig viele Pakete ins Netz zu pumpen  |
| je mehr Verbindungen sie paralel eroeffnet            |                                                            |
+-------------------------------------------------------+------------------------------------------------------------+
| Parallele Verbindungen sind nicht fair                |   UDP ist generell nicht fair gegenueber TCP               |
+-------------------------------------------------------+------------------------------------------------------------+


.. _IP:

IP v4
=====

Im Folgendem wird die Version 4 des IP behandelt.

Charakterisitker
----------------

* Verbindungsloser Datagramm - Dienst
* Nachrichten werden im "store and forward" - Prinzip von der Quelle zum Ziel weiter geleitet (e.g. Brief)
* IP-Pakete sind die PDUs des IP Protokoll
* Nachrichten koennen segmentiert und in einer Serie von IP-Paketen hinterlegt werden
* Jedes IP-Paket wird seperat weiter geleitet

|

* **Keine Reihenfolgentreue**
* **Keine Garantie maximaler Latenz**
* **Keine Verlustfreiheit**

Adressen
--------

IP Adressen sind 32-Bit Adressen, aufgeteilt in 4 Byte-Gruppen.
Es existiert jeweils eine Adresse fuer jedes Netz-Interface des Knotens (Router)

Interclass Domain 

Header
-----------

* Version
* Header Laenge
* Type of Service
* Datagramm Laenge
* 16-Bit Identifizierer
* Flags
* 13_Bit Fragmentierungs Offset
* Time To Live
* Hoeherschichtiges Protokoll
* Header-Pruefsumme
* 32-Bit-Quelladresse
* 32-Bit-Zieladresse
* Optionen
* Daten

Fragmentierung / Reassemblierung
--------------------------------

Im Zielrechner werden die IP-Pakete vor der Weitergabe an die Transportschicht zusammengesetzt.
Ist ein Paket verloren gibt es keine Weitergabe)

Der Offset kennzeichnet wo das Datagramm geteilt wurde.

IP v6
=====

Im Folgendem wird die Version 6 des IP behandelt.

Die Motivation von IP v6 ist die Anzahl an Adressen. Eine IP v6 Adresse umfasst 128 Bit.

Header
------

Obwohl die Adressen groesser sind ist der Header "schmaler"

* Version
* Prioritaet
* Flusslabel
* payload length
* next header
* hop limit
* Quelladresse
* Zieladresse
* Daten
