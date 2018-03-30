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

c is the the function for the fuzzy complement

.. math::

    c:[0,1] \rightarrow [0,1]\\
    c(0) = 1, c(1) = 0\\
    \forall a,b \in [0,1]: a \leq b \Rightarrow c(a) \geq c(b)

t(x)
^^^^

the t norm is the intersection

.. math::

    t(a,1) = a\\
    b \leq d \Rightarrow t(a,b) \leq t(a,d)\\
    t(a,b) = t(b,a)\\
    t(a, t(b,d)) = t(t(a,b), d)

s(x)
^^^^

s is the function for the union

.. math::
