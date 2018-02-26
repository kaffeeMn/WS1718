Zusammenfassung Der Protokolle
##############################

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

Anwendungsbeispiele
-------------------

* E-Mail
* remote terminal access
* WWW
* Dateitransfer
* streaming

|

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



TCP PDU-Format
==============

