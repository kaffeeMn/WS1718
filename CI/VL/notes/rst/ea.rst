#######################
Evolutionary Algorithms
#######################

Table of Contents
#################

Script
######

Optimization Basics
===================

optimization itself, is the process of optimizing a system with unknown input.

a objective function f projects a *feasible region* X to R

the objective is to find a solution with minimal or maximal value. (minima/ maxima
of f)

N ist the neighborhood function, N(x*) is a bounded subset of (X), consisting of the
neighborhood of x*.
local solutions can be termined as following:

.. math::

    \forall x \in N(x*) : f(x*) \leq f(x) \RighLeftarrow \text{x* is locla solution}

when to use which optimization method?
--------------------------------------

* don't apply EAs: mathematical algorithms
    + explicitly specific pronlem
    + problem specific solver available
    + pronlem is well understood
    + ressources for designing algorithm are affordable
    + solution with proven quality required
* EAs are worth a try: randomized search heuristics
    + problem given by a grey or black box
    + no solver available
    + problem is poorly understood
    + insufficient recources for designing algorithm
    + solutions with satisfactory quality sufficient

EA Basics
=========

The idea of an EA is to use biological evolution as a pool of inspiration.

* feasible solutions represent chromosomes.
* a multiset of feasible solutions represents a population
* the objective function is used as a fitness function for individual chromosomes

algorithmic skeleton
--------------------

1. initialization of population
2. evaluation
3. parent selection while not stopflag is set
    * variation (yielding of offspring)
    * evaluation of offspring
    * survival selection of offspring
4. output is the best individual found

(1+1)
-----

(1+1) EA have a population size of 1 and a parent yields 1 offspring.

selection
---------

an EA needs to select:

1. parents for offspring
2. surviving offspring

it goes without saying that
* selection step must *not* favor worse individuals
* one selection stepmay be neutral
* at least one selection step must favor better individuals

Typically the selection is based upon the fitness values of individuals.
Seldomly on chromosomes, to maintain diversity in offspring.

(n,l)
^^^^^

ranking offspring (l) according to their fitness
select n offspring with best ranks

(l needs to be greater or equal to n otherwise best individuals may get lost.)

(n+l)
^^^^^

like (n,l), with the exception, that n and l will be merged, then ranked and then 
selected.
That way the best individuals are guaranteed to survive.

elitism
^^^^^^^

in elitism, the best parent is not replaced by a worse individual. 

* inrinsic: choses from parent and offspring, the best survives with probability 1
* forced: if the best individual has not survided, then it will be reinjected into
    the population. The worst individual will be replaced by the previously best
    parent



variation
---------
