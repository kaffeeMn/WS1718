3 Wege Handshake
################

Schrit 1
========

Der Client Host sendet ein SYN Segment zum Server.

Dabei wird eine Initiale Sequenznummer initialisiert. Das Segment selbst enthaelt keine Daten.

Schritt 2
=========

Der Server Host empfaengt SYN und antwortet mit einem SYNACK

Dabei wird der Buffer-Platz vom Server allokiert, sowie die initiale Sequenznummer des Servers spezifiert.

Schritt 3
=========

Der Client empfaengt SYNACK und antwortet mit einem ACK Segment, das Daten enthalten kann.
