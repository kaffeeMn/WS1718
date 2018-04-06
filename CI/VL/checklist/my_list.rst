fuzzy
=====

algebraisches Produkt:
----------------------

t-norm and other norms
^^^^^^^^^^^^^^^^^^^^^^

given a constructor g

t-norm is the intersection

* A1 t(a,1) = a
* A2 b <= c: t(a,b) <= t(a,c)
* A3 t(a,b) = t(b,a)
* A4 t(a, t(b,c)) = t(t(a,b),c)

the t-norm can be solved using the generator aswell

t(a,b) = g^-1(min{g(0), g(a) + g(b)}) 

|

s norm is the union

* A1 s(a,0) = a
* A2 b <= c: s(a,b) <= s(a,c)
* A3 s(a,b) = s(b,a)
* A4 s(a,s(b,c)) = s(s(a,b),c)

the s-norm can be solved using the generator aswell

s(a,b) = g^-1(-log(1-a) - log(1-b))

|

c norm is the compliment

* A1 c(0) = 1; c(1) = 0
* A2 a <= b: c(a) >= c(b)

the c-norm can be solved using the generator aswell

c(a) = g^-1(g(1) - g(a))

dual triple axiome
^^^^^^^^^^^^^^^^^^

for a triple to be considered a dual triple, all axioms must be valid and the following axioms have to be true aswell:

* (A1) duality of t to c: c(t(a,b)) = s(c(a),c(b))
* (A2) duality of s to c: c(s(a,b)) = t(c(a),c(b))

Implikationsform generator (fuzzy)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

axioms

* a<=b -> Imp(a,x) <= Imp(b,x) and Imp(x,a) <= Imp(x,b)
* Imp(0,a) = 1
* Imp(1,a) = a
* Imp(a,a) = 1
* Imp(a,b) = Imp(c(b), c(a))

or it exists a strictly monotone increasing function f with

+ f(0) = 0
+ Imp(a,b) = f^-1 (min{f(1)-f(a)+f(b), f(1)})
+ c(a) = f^-1(f(1)-f(a))

|

S-Imp:

* a => b === not(a) or b
* Imp(a,b) = s(c(a),b)

R-Imp:

* a => b == max{ x : a and x <= b}
* Imp(a,b) = max{t(a,x) <= b}

QL-Imp:

* a => b === not(a) or not(a and b)
* s(c(a), c(t(a,b)))

FITA vs. FATI
^^^^^^^^^^^^^

first interfere then aggregate

first aggregate then interfere

|

when are they equivalent?

they are equivalent if alpha = beta and for the agregation a sup-t norm is used.


nn
==

McCulloch-Pits
^^^^^^^^^^^^^^

binary input, threshold, neuron gives binary output.


Hopfield-Netz
^^^^^^^^^^^^^

Energy function:

.. math::
    
    E(x) = -0.5 * t(x) W x + t(\Theta) x

stable if energy has been minimized

ea
==

hypervolume
^^^^^^^^^^^

volume contributed by all data-points (individuals/ solutions)

measured by reference point

variationsoperationen
^^^^^^^^^^^^^^^^^^^^^

* eigenschaften
* R^n

non-dominant sort
^^^^^^^^^^^^^^^^^

always the next line of non-dominated solutions.

Other
=====

Covariance matrix
-----------------

inverse of the hessian matrix
needs to be positively definite

RBF weights
-----------

theta R^n -> R is a radial basis function, if it exists a phi with:

.. math::

    \forall x \in \R^n : \theta(x;c) = \phi(|| x-c ||)\\

it is local, if:

.. math::

    \phi(r) = 0, \text{ as } r \rightarrow \infty

setting the weights:

p_ik = \phi(|| x_i - c_k ||)

Pw=y

w = (t(P)P)^-1 t(P) y
  = P^+ y

MLP weights
-----------

back propagation

w_ij^(t+1) = w_ij^(t) - gamma * o_i * delta_j

with w as the weight, gamma as gamma_t = gamma / (t+1) and gamma > 0
, o as the output of the neuron, delta as the gradient/
size of error


Variations
----------

* mutation
    + swapping inverting bit-strings
        - local (flip random bit
        - global flip each bit with a probability
        - nonlocal flip k indices
        - inversion invert bits between indices k_s, k_e
* recombination
    + crossovers, crossing over bits of parents to new bitstring
        - 1, k point
        - uniform

mutation alters a single individual

recombination yields offspring from parents

define a RBF
------------

FATI FITA use
-------------
