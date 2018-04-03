.. todo::
   involutive complement
##########
Fuzzy Sets
##########

Table Of Contents
#################

Script
######

Basic Definition
================

What makes communication human is its lack of precision. e.g.

"When the water ist too hot, just add a little bit of cold water."

Now this instruction could be regarded as rather vague or "fuzzy", but a human
can work with these instructions.

|

Consider the statement "Water is too hot."

That means, that the watertemperature is an intervall that is regarded as "too  hot"


Definition
----------

A map F with .. math::

    F: X \rightarrow [0,1] \in \R

that assigns its degreee of membership F(x) for each x in a set of X, is termed a 
**fuzzy set**.

Axioms and Rules
^^^^^^^^^^^^^^^^

Empty(O) if

.. math::

    \forall x \in X. F(x) = 0

Universal(U) if

.. math::

    \forall x \in X. F(x) = 1

|

Fuzzy sets of the same crip set X can be:

* equal
* subsets
* strict subset

|

fuzzy sets share the relations of:

* reflexivity
* antisymmetry
* transitivity

|

Therefore the union, intersection and complement of fuzzy sets can be calculated

|

the parameter height and depth of a fuzzy set are defined by their supremum and
infimum.

Further more a fuzzy A set is:

* normal, if its height is 1
* strongly normal if it exists an x with A(x) = height
* co-normal, if the depth is 0
* strongly co-normal if it exists x with A(x) = depth
* subnormal if normal and co-normal

|

the cardinality is either the sum or integral of A over X, depending of the Set of
numbers X is a subset of.

|

as for the rules a fuzzy set is:

* cummutative
* associative
* idempotent
* monotone

Norms
-----

c(x)
^^^^

c-norm is the the function for the fuzzy complement

.. math::

    \text{(A1)} c:[0,1] \rightarrow [0,1]\\
    \text{(A2)} c(0) = 1, c(1) = 0\\
    \text{(A3)} \forall a,b \in [0,1]: a \leq b \Rightarrow c(a) \geq c(b)

* (A1,2) monotone decreasing
* ((A3,4) involutive)

t(x)
^^^^

the t norm is the intersection

.. math::

    \text{(A1)} t(a,1) = a\\
    \text{(A2)} b \leq d \Rightarrow t(a,b) \leq t(a,d)\\
    \text{(A3)} t(a,b) = t(b,a)\\
    \text{(A4)} t(a, t(b,d)) = t(t(a,b), d)

* (A1) boundary condition
* (A2) monotonicity
* (A3) commutative
* (A4) associative

s(x)
^^^^

s-norm is the function for the union

.. math::

    \text{(A1)} s(a,0) = a\\
    \text{(A2)} b \leq d \Rightarrow s(a,b) \leq s(a,d)\\
    \text{(A3)} s(a,b) = s(b,a)\\
    \text{(A4)} s(a, s(b,d)) = s(s(a,b), d)\\

* (A1) boundary condition
* (A2) monotonicity
* (A3) commutative
* (A4) associative

duals
^^^^^

a t-norm and s-norm form a dual with regard to a c-norm, if:

* c(t(a,b) = s(c(a), c(b))
* c(s(a,b) = t(c(a), c(b))

Now, if s and t are dual to c, then (c,s,t) is a dual triple.

Why are dual triples important?

Dual triples allow equivalence transformations of fuzzy set expressions.§
Without dual triples, DeMorgans law is not guaranteed to work.

Relations
=========

generally speaking: reltations of variables are a subset of or equal to the kartesian
product of those varables.

Fuzzy relations return a degree of membership to the realtion for given input.

The membership matrix R is defined as 

.. math::

    R \in [0,1]^{|X|, |Y|}\\
    \text{with input variables } X, Y\\
    R^{-1} = t(R)

operators
---------

the max-min-composition is denoted as following

.. math::

    \text{with fuzzy relations } P(X,Y), Q(Y,Z)\\
    R(x,z) = (P \circ Q)(x,z) = max-min_{y \in Y}{P(x,y), Q(y,z)}

|

the max-min composition is

* assoziative
* commutative

therefore :

.. math::

    (P(X<Y) \circ Q(Y,Z))^{-1} = Q^{-1}(Z,Y) \circ P^{-1}(Y,X)

the max-min-composition replaces the crisp matrix multiplication

Logic
=====

linguistic variables and terms
------------------------------

p: *temperature* is **high**

the proposition consists fo a linguistic *variable* and **term**

in fuzzy logic a term are numbers in [0,1]

The Trueness of the proposition is T(p) = high(temperature)

inference from fuzzy statements
-------------------------------

IF heat is hot THEN energy consumption is high

We need to determine the trueness of the implication. There are multiple implication
functions. The fuzzy implication has the following axioms:

.. math::

    \text{monotone first argument } a \leq b \text{ implies } Imp(a,x) \leq Imp(b,x)\\
    \text{monotone second argument } a \leq b \text{ implies } Imp(x,a) \leq Imp(x,b)\\
    \text{dominance of falseness } Imp(0,a) = 1\\
    \text{neutrality of trueness } Imp(1,b) = b\\
    \text{identity } Imp(a,a) = 1\\
    \text{exchange property } Imp(a, Imp(b,x)) = Imp(n, IMp(a,x))\\
    \text{boundary condition } Imp(a,b) = 1 IF a \leq b\\
    \text{contraposition } Imp(a,b) = Imp(c(b), c(a))\\
    \text{continuity} \\

Approximate Reasoning
=====================

FITA VS FATI
------------

FITA is the approach of "first interference them aggregate"

1. In FITA we need to firstly transform each rule by an appropraite fuzzy implication
    Imp(.,.) to a relation R
2. we determine B'(y) = R(x,y)oA'(x) for all Implications in R
3. we aggregate to B'(y) = betta(B_1'(y), ..., B_n'(y))

FATI is the approach of "first aggregate then interference"

1. In FITA we need to firstly transform each rule by an appropraite fuzzy implication
    Imp(.,.) to a relation R
2. we aggregate to R'(x, y) = aplpha(R_1(x, y), ..., R_n(x, y))
3. we determine B'(y) = R'(x, y)oA'(x) (superrelation inference)

choices for R
-------------

Mamdani

.. math::

    R(x,y) = min{A(x), B(x)}

Larsen

.. math::

    R(x, y) = A(x) * B(x)

Control
=======

Clustering
==========

Crisp K clustering algorithm
----------------------------

1. for k in {1,...,K}:
    * C_k = {}
2. for x in {x_1,...,x_N}:
    * assign x to some cluster C_k
3. t = 0; D(t) = inf;
4. while D(t-1) - D(t) >= epsilon:
    * t += 1
    * for k in {1,...,K}:
        + x~_k = 1/| C_k | * SUM_{x in C_k}(x)
        + for i in {1,...,N}:
            - d_ik = d(x_i,x~_k)
        + choose k*, so that: d_ik* = min{d_ik : k in {1,...,K}}
        + assign x_i to C_k*
    * D(t) = SUM_{k in {1,...,K}}(SUM_{x in C_k}(d(x, x~_k)))
