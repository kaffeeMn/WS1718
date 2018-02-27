rdt
===

Methoden
--------

rdt_send()
^^^^^^^^^^

Weitergabe der zu sendenden Daten.

udt_send()
^^^^^^^^^^

Uebertragung eines Pakets ueber den unzuverlaessigen Kanal
zum Empfaenger

rdt_rcv()
^^^^^^^^^

Aufruf nach empfangen des Paketes. weiter an hoehere Schicht.

1.0
---

Annahme
^^^^^^^

Basisdienst Fehlerfrei

Verfahren
^^^^^^^^^

+-------------------------------+---------------------------+
| Sender                        | Empfaenger                |
+===============================+===========================+
| rdt_send()                    | auf Sender warten         |
|                               +---------------------------+
| - packet = make_pkt(data)     | rdt_rcv()                 |
| - udt_send(packet)            |                           |
+-------------------------------+ - extract(paket, data)    |
| auf empfaenger warten         | - deliver_data(data)      |
+-------------------------------+---------------------------+



2.0
---

Annahme
^^^^^^^

Basisdienst nicht Fehlerfrei

Verfaelschungsbehandlung
^^^^^^^^^^^^^^^^^^^^^^^^

1. ARQ
   "Automatic Repeat Request"

    * Fehlererkennung: Fehlererkennender Code
    * Fehlerbehebung: Wiederholung, eingeleitet durch Rueckmeldung

|

2. FEC
   "Forward Error Correction"

   * Fehlerkorrigierender Code

ARQ
^^^

+-------------------------------------------+
| Sender                                    |
+===========================================+
| Sende Nachricht                           |
| rdt_send(data)                            |
|                                           |
| * snkpkt = make_pkt(data, checksum)       |
| * udt_send(snkpkt)                        |
+-------------------------------------------+
| warte auf Quitung und checke              |
| rdt_rcv(rcvpkt) && isNAK(rcvpkt)          |
| rdt_rcv(rcvpkt) && isACK(rcvpkt)          |
+-------------------------------------------+

Der Empfaenger empfaengt das Paket und sendet ACK oder NACK
an den Sender

2.1
---

Motivation
^^^^^^^^^^

rdt2.0 hatte das problem, dass der Sender nicht weiss was empfangen wurde. Neusenden ist wegen einer moeglichen
Doppeluebertragung nicht ratsam.

|

deshalb wird das Paket mit einer Sequenznummer erneut gesendet wenn ACK/NAK beschaedigt sind.

Ablauf
^^^^^^

Wie 2.0, nur dass ein zweites Paket gesendet wird, wenn NAK/ ACK beschaedigto

|

Sender

* Fuegt Sequenznummer zu jedem Paket hinzu
* Muss jedes empfange ACK/ NAK auf Korrektheit ueberpruefen

Empfaenger

* Muss Pakete auf doppelte Uebertragunf untersuchen
* weiss nicht,ob der Sender das ACK/ NAK empfangen hat

2.2
---

Motivation
^^^^^^^^^^

Es reichen positive Quittungen aus

Ablauf
^^^^^^

Wie 2.1

* statt NAKs sendet der Empfaenger ein ACK fuer das letzte fehlerfreie Paket.
* auf doppelte ACKs reagiert der Sender wie auf NAK (erneutes senden)

3.0
---

Annahme
^^^^^^^

Pakete (Daten oder ACKs) koennen verloren gehen

Ablauf
^^^^^^

* Sender wartet eine festgelegte Zeit, bis er sich sicher sein kann, dass das Paket verloren ging.
* Wenn kein ACK bis dahin angekommen ist wird das Paket erneut gesendet. bei Verzoegerung wird doppelt gesendet
   (Erkennung durch Sequenznummer)
* Sequenznummer muss auch im ACK angegeben werden

| 

1. Bei senden "Wecker" starten
2. Warten auf Quittung oder "Weckeralarm"
3. Wecker stoppen
4. Weckalarm wie negative Quittung behandeln und erneut senden

PRO und CONS
^^^^^^^^^^^^

========================================    ======================================== 
PRO                                         CONS
========================================    ======================================== 
bietet eine sichere Uebertragung            schlechte Leistung (Stop And Go)
========================================    ======================================== 
