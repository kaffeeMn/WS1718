Ueberlastungskontrolle
######################

Die Ueberlastungskontrolle dient dazu Stau zu verhindern.

Dabei wird auf die Flusskontrolle zurueck gegriffen.

    * Messen der momentanen Belastung
    * Berechnen des moeglichen Flusses
    * Entsprechendes Drosseln des Flusses

|

Staus
=====

Staus koennen verschiedene Ursachen haben. 

e.g.:

* unbeschraenkter Buffer -> Prozesse ueberlasten das System und klauen sich gegenseitig die Kapazitaeten
* beschraenkter Buffer ...
    + ... aber Segmente gehen ueber Buffer-Ueberlaufe verloren. Wiederholte Uebertragungen erzeugen zusaetzliche
      Last und damit zusaetzlichen verkehr
    + ... aber gemeinsame Routen fuehren zu Paketverlusten bei allen Verbindungen und damit auch zu Wiederhilen auf
      allen Verbindungen

|

Ansaetze
========

Ende zu Ende Ueberlastungskontrolle
-----------------------------------

* Die Vermittlungsschicht unterstuetzt nicht explizit
* Ueberlastung wird durch Paketverlust und -verzoegerung festgestellt. Fenstergroesse wird 

Ueberlastungskontrolle im Netz
------------------------------

* Komponenten der Vermittlungsschicht (Router) geben dem Sender explizit Feedback ueber Ueblastzustaende
    + e.g. DECnet, TCP/IP ECN, ATM ABR
* Sender bekommt eine expliziete Senderate zugeteilt


ATM ABR
^^^^^^^

ABR (available bit rate):

* Elastischer Dienst
* Wenn Pfad vom Sender zum Empfaenger nicht ausgelastett ist soll der Sender die verfuegbare Bandbreite nutzen.
* Wenn der Pfad vom Sender zum Empfaenger ueberlastet isr darf der Sender nur eine minimale garantierte Bandbreite nutzen.

ABR wird durch das senden von RM zwischen den Datenzellen realisiert.
Der empfaenger sendet RM zurueck.

RM - Zellen (resource management):
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Informationen ueber Netzzustand, werden von switches gesetzt
* NI bit inidiziert leichte ueberlastung
* CI bit indiziert Ueberlast

