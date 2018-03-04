Die Vermittlungsschicht
#######################

Table Of Contents
#################

* Datagramm_
* Router_
* Routing_Algorithmen_
* Internet_

Skript
######

.. _Datagramm:

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

e.g.

=========================================== =======
Zieladressbereich                           Ausgang
=========================================== =======
11001000 00010111 00010*** *********        0
11001000 00010111 00011000 *********        1
11001000 00010111 00011*** *********        2
sonst                                       3
=========================================== =======

|

.. _Router:

Router
======

Ein Router hat zwei Hauptfunktionen 

1. Vermittlung von IP-Paketen und deren Weiterleitung
2. Pflege von Routingtabellen per PIP/OSPF/BGP

Weiterleitung
-------------

Weitergabe eines Paketes vom Eingang eines Routers zum richtigen Aussgang.

Routing
-------

Bestimmung der Route vom Sender zum Empfaenger durch einen routing Algorithmus.

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
    * Ziel: eingehende Pakete entsprechend der Eingangsleitung bearbeiten
    * Zwischenspeicherung(queuing): wird angewandt wenn Pakete schneller ankommen, als der Router sie verarbeiten kann

Switching Fabric (Vermittlung)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Es gibt 3 Typen von Switching Fabrics:

1. memory
2. bus
3. crossbar

Ausgang-Port
^^^^^^^^^^^^

3 Schichten:

1. datagramm buffer (queueing)
    * Buffern von Datgrammen, wenn diese schneller ankommen, als sie uebertragen werden koennen
    * (scheduling notwendig)
2. link layer protocol
    * Protokoll der Sicherungsschicht
3. line termination
    * Bituebertragung

Blockierung
-----------

Blockierungen entstehen dann, wenn zu viele Pakete fuer einen Ausgang generiert werden.
Dies kann zu Wartezeiten, Buffer-Ueberlaufe und Paketverluste fuehren

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


.. _Routing_Algorithmen:

Routing-Algorithmen
===================

Ein Netzwerk von Routern kann auch als Graph betrachtet werden. Eine Uebertragung in einem Netz ist dann Effizient, wenn
der Kuerzeste Weg von einem Knoten(Router) zum anderen innehalb des Graphen gewaehlt wurde.
In der Graphentheorie existieren solche Algorithmen

Klassifizierung von Algorithmen
-------------------------------

Global
    * jede Kante, Kantenverlauf und Kosten werden global erkannt.
    * Problem: Skalierbarkeit, Aenderungsaufwand
Denzentral
    * Jeder Router kennt nur die Kanten zu senen Nachbarn
Statisch
    * Kantenverlauf und Kosten aendern sichr nicht
Dynamisch
    * Kanten verschwinden, kommen dazu
    * Kosten aendern sich
    * Problem: Schleigenbildung durch dynamische Suche

Im Internet
-----------

Im Internet werden fuer gewoehnlich die Algorithmen "Link State" (dynamisch, global) und "Distance Vector" (dynamisch, dezentral)

Graph
^^^^^

Ein Graph, mit Knoten von Routern sei wie folgt definiert:

.. math::

    K =^{def} \text{ Knotenmenge des Graphen}\\
    c(i,j) =^{def} \text{ Verbindungs-Kosten von Kante i nach j}\\
    c(i,j)=\begin{cases}
        \text{Kosten der Kante, falls eine solche existert}\\
        \infty \text{, sonst}
    \end{cases}\\
    D(v) =^{def} \text{ Kosten des bisher besten Pfades vom Sender zum derzeitigen Ziel v}\\
    N =^{def} \text{ Menge der Knoten, bei denen ein Pfad mit geringsten Kosten vom Sender bekannt ist}

Link-State (Dikkstra)
^^^^^^^^^^^^^^^^^^^^^

Der Algorithmus berechnet einen Weg mit minimalen Kosten von einem Senderknoten zu jegem potentiellen Empfaenger in

.. math:: 

    O(n^2), n = |K|


Der Algorithmus bekommt einen Graphen wie zuvor definiert und einen Startknoten uebergeben

.. math::

    link \_ state(G(K,c), v_0):\\
    \ \ \ \ N = \{v_0\}\\
    \ \ \ \ \\
    \ \ \ \ \forall v \in K:\\
    \ \ \ \ \ \ \ \ \text{if v adjacent to } v_0:\\
    \ \ \ \ \ \ \ \ \ \ \ \ \text{then } D(v) = c(v_0,v)\\
    \ \ \ \ \ \ \ \ \ \ \ \ \text{else } D(v) = \infty\\
    \ \ \ \ \\
    \ \ \ \ \text{while } N \nequiv K:\\
    \ \ \ \ \ \ \ \ \text{find } w \in K. w \notin N \text{ so that } D(w) \text{ is a minimum}\\
    \ \ \ \ \ \ \ \ N = N \cup \{w\}\\
    \ \ \ \ \ \ \ \ \text{for all v adjacent to w and not in N}:\\
    \ \ \ \ \ \ \ \ \ \ \ \ D(v) = min( D(v), D(w)+c(w,v))\\
    \\
    \ \ \ \ return \ D

Distance Vector
^^^^^^^^^^^^^^^

Die Vorueberlegung des Distance Vector Algorithmus sind Bellman-Ford-Gleichungen

Es sei

.. math::

    d_x(y) =^{def} \text{Kosten guenstigster Pfad von x nach y}
    d_x(y) =^{def} min\{c(x,v) + d_v(y)\}

Auf Basis dessen laesst sich ein dynamischer Ansatz fuer die Loesung des Problems waehlen

Jeder Knoten schickt ein Palet ueber den direkten Nachbarn. ueber den die geringsten Kosten entstehen. Darueber laesst sich
eine Distanztabelle Erstellen.

.. math::

    distance \_ vector(G(K,c)):\\
    \ \ \ \ D = \infty^{n \times n \times n}\\
    \ \ \ \ \forall v. c(x,v) \neq \infty:\\
    \ \ \ \ \ \ \ \ D_x(v,v) = c(x,v)\\
    \ \ \ \ \text{Sende } min_w D_x(y,w) \text{ an alle Nachbarn}\\
    \ \ \ \ Iteriere:\\
    \ \ \ \ \ \ \ \ \text{warte bis sich Leitungskosten c(x,v) aendern oder neue Informationen von einem Nachbarn eintreffen}\\
    \ \ \ \ \ \ \ \ \text{if } c(x,v) \text{ aendert sich um} d:\\
    \ \ \ \ \ \ \ \ \ \ \ \ D_x(y,v) = D_x(y,v) + d\\
    \ \ \ \ \ \ \ \ \text{if Nachbar v schickt neien Wert val seines Weges zu y}\\
    \ \ \ \ \ \ \ \ \ \ \ \ D_x(y,v) = val + c(x,v)\\
    \ \ \ \ \ \ \ \ \text{sende neue Werte min_w D_x(y,w) an alle Nachbarn}\\

Leitungsvermittlungsalgorithmen
===============================

Dijkstra
    * minimale Anzahl an Hops
Least Loaded Path (LLP)
    * am wenigsten benutzte Kanaele
Maximum Free Circuit (MFC)
    * groesste Anzahl freier Kanaele

|


.. _Internet:

Routing im Internet
===================

In der Realitaet weicht Routing von der Graphentheorie, durch Fehlerbehaftung ab.

Probleme sind

* Dimension
    + Ziele koennen nicht alle in Routingtabellen gespeichert werden
    + schon der Nachrichtenaustausch zum Routing kann das Netz ueberlsten
* Autonomie
    + Das Internet ist ein Netz von Netzen und jeder Admin moechte das Routing in seinem Netz kontrollieren

Das Routing im Internet wird durch das IP-Protokoll ermoeglicht (siehe `Protokolle <../html/protocols.html>`_)

Interclass Domain Routing (IP)
------------------------------

* Adresszuweisung fuer Originastionen durch ISP
* a.b.c.d/NumNetworkBits

Uebergang v4, v6(IP)
--------------------

Der Uebergang von v4 auf v6 laeuft seit Jahren

um beide moeglichkeiten zeitgleich zu betreiben gibt es zwei Moeglichkeiten

1. Dual Stack
2. Tunneling

Dual Stack
^^^^^^^^^^

Router verstehen v4 und v6. Informationen werden uebersetzt. Zusaetzliche Informationen von v6 gehen dabei verloren.

Tunneling
^^^^^^^^^

Beispiel fuer Tunneling ist Austausch bei dem Router B, E sowohl v4, als auch v6 verstehen. Router A,F verstehen nur v6, 
Router C,D verstehen nur v4.
Tunneling beschreibt den Vorgang, indem v6 Daten in einem v4 Paket von B ueber C und D nach E verschickt werden, wo sie
dann entpackt und als v6 Daten weiterversendet werden, oder umgekehrt.
Dabei werden keine Zusaetzlichen Informationen aus v6 verloren.

ICMP
----

Internet Control Message Protocol
