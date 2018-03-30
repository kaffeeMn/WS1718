.. todo::
   hopkins nets
###########
Neural Nets
###########

Table of Contents
#################

Script
######

McCulloch-Pitts-Neuron
======================

The First shallow Neural Networks we learned about were based on McCulloch-Pitts
neurons.

The McCulloch-Pitts Neuron take an array of numbers as input

.. math::

    n_i, \forall n \in N_i . n \in \B

that array is then processed by an activation function f. If the output value
processed within f is greater than or euqal to a threshold, the neuron fires.

.. math::

    \text{Threshold: } \Theta\\
    f(n) = \begin{cases}
        1, \Sum^{len(n)}_{i=1} > \Theta\\
        0, else
    \end{cases}

Logical Functions
-----------------

Every logical function can be simulated with a two layered McCullocj-Pitts net.

e.g.:

.. math::
    F(x) = f_1(x_{1-3}) \lor f_2(x_{4-6}) \lor f_2(x_{7-8})\\
    \text{with } 
    f_1(x) = x_1 \land x_2 \land \not x_3, 
    f_1(x) = \not (x_1 \lor x_2 \lor x_3), 
    f_1(x) = x_1 \land \not x_2, 

decimal numbers
---------------

A net with decimal numbers can be simulated by a net with natural numbers, by simply
duplicating the inputs for a neuron.


|

Minsky Papert Perceptron
========================

The MPP works much like the MCP, with the difference, that weighted input consists
of real numbers. And gives binary output.

The MPP essentially draws lines seperating true and false output.
Much like the MCP a MPP with two layers and a non-linear activation function
can simulate any logical function.

Learning
--------

Perceptrons can be trained, if test examples with corect I/O are provided.
P is defined as the set of positive examples, N as the set of negative examples.
t is defined as the transponation function.

.. _perceptron_learning_algorithm:

The perceptron learning algorithm:

1. choose w0 at random, t = 0
2. choose arbitrary .. math:: 
     x in P \cup  N
3. .. math::
    \text{if } x \in P \land t(w_t) * x > 0 \text{then goto 2}\\
    \text{if } x \in N \land t(w_t) * x \leq 0 \text{then goto 2}
4. .. math::
    \tex{if } x \in P \land t(w_t) * x \leq 0 \text{then }\\
    w_{t+1} = w_t + x; t++; \text{goto 2}
    \text{if } x \in P \land t(w_t) * x \leq 0 \text{then }\\
    w_{t+1} = w_t - x; t++; \text{goto 2}
5. stop when all I/O have been guessed correctly

Overview: Multi-layered MPP
---------------------------

A single-layered MPP can seperate a plane into two halves.
A multi-layered MPP can identify convex sets.

=================== ===========================================================
layers              possibilities
=================== ===========================================================
1                   plane in halfes
2                   convex sets
3                   arbitrary sets
>3                  not necessary in shallow learning
=================== ===========================================================

arbitrary sets partition non convex sets in serveral convex sets.

* two layered subnet for each convex set
* feeding outputs of two layered subnets into an OR gate

Single-Layer-Perceptron
=======================

Accelerated learning
--------------------

We defie the test set B as .. math::
    B = P \cup {-x : x \in N}, x \in \B

now we define the absolute amount of x as .. math::
    ||x|| = \Sum^{n}_{i=1} |x_i| \greq 1

Therefore if a test example was classified incorrectly, .. math::
    t(w) * x < 0\\
    \delta = -t(w) * x > 0

can be assumed, with delta as the error size for x

for the weights of the next itteration this means:

.. math::
    w_{t+1} = w_t + (\delta + \epsilon) * x\\
    \Rightarrow t(w_{t+1}) * x = t(w_t + (\delta + \epsilon) * x) * x\\
    = ... = \delta * (||x||^2 - 1) + \epsilon * ||x||^2 > 0

epsilon is a small number, needed for w to be greater than 0 in all cases

|

Now with x in the range of real numbers, things get more complcated.

.. math::
   ||x|| > 0 \text{, but } \delta * (||x||^2 - 1) \text{ can be smaller than 0}

therefore our set B needs to be scaled, so that all x are greater than or equal to 1

.. math::
    l = min{||x|| : x \in B} > 0\\
    ||x^{^}|| = ||x/l|| \greq 1
    B^{^} = {x^{^} : x \in B}

formula to correct weights
^^^^^^^^^^^^^^^^^^^^^^^^^^

w should converge to w* with increasing itterations t

.. math::
    \text{if } t(w_t) * x < 0 \text{then:}
    w_{t+1} = w_t + \gamma_t * x

with

1. .. math::
    \forall t \leq 0 : \gamma \leq 0
2. .. math::
    \Sum^{\infty}_{t=0} \gamma_t = \infty
3. .. math::
    lin_{m \rightarrow \infty} \frac{
        \Sum^{\infty}_{t=0} \gamma_t^2
        }{
        (\Sum^{\infty}_{t=0} \gamma_t)^2
        } = 0

with that formula the perceptron can be addapted to work with the 
perceptron_learning_algorithm_

Online- vs. Batchlearning
-------------------------

as of now we have been introduced to the "online learning" approach.
* Updating of wheights after each training pattern

another approach to update the wheights is batch-learning
* updating of wheights after test of training patterns
* rule for updates is .. math::
    w_{t+1} = w_t + \gamma_t * \Sum_{t(w)*x<0 \land x \in B} x

the upside of batch learning is that it is faster, the downside is that it takes up
a large amount of memory (large Array for all wrong x)
    
Multi-Layer-Perceptron
======================

Quantification of classification Error
--------------------------------------

TSSE vs. TMSE

Essentially the sum and mean square error do the same thing.

output of the net so far has been either 1 or 0. Now, that we want to minimize the error
and get as close to the right answeer as possible, we use non-linear activation functions,
with output in [0,1]

that way the activation function can be differtiated, and a gradient_method_ can be
applied to the net.

.. _gradient_method:

The Gradient Method
^^^^^^^^^^^^^^^^^^^

the gradient method f takes the weights w,u of the net and calculated the TSSE

the weights of the next iteration of the net are then updated like .. math::

    w_{t+1} = w_t - \gamma * \? * f(w_t, u_t)

to get the gradient of the error calculated by f, we need to partially derive f, before
subtracting the error.

General Approach
^^^^^^^^^^^^^^^^

1. determine error signals of output neuron
2. use the signals to calculate the error signals of the precending layers
3. repeat 2 until reaching the first inner layer

That way the error is propagated backwards from the output to the first inner layer.

Applications
------------

Classification
^^^^^^^^^^^^^^

The training pattern is provided by (input = X~ and output = Y~)

in classification outputs are labels of classes.

The use of classification nets is broken down in two steps:

1. train the network
2. apply it to unknown inputs for classification

Prediction of Time Series
^^^^^^^^^^^^^^^^^^^^^^^^^

X is a time series x1, ... ,xt like temperature, exchange rates, etc.


The use of time series nets is broken down in two steps:

1. train the network
2. apply network ti historical inputs for predicting unknown outputs

Function Approximation
^^^^^^^^^^^^^^^^^^^^^^

given a training et of x and y values of an arbitrary function, the net shall
approximate that function

Recurrent Nets
--------------

Jordan Nets
^^^^^^^^^^^

A recurrent MLP feeds the output back into the first inner layer

Elman Nets
^^^^^^^^^^

MLP + context neuron for each hidden layer. The context neuron feeds back the output
of a neuron to itself.

Radial Basis Function Nets
--------------------------

given are N training patterns

A function 

.. math::
    
    f: \R \rightarrow \R

is termed a *radial basis function*, if 

.. math::

    f(x) = w_1 \phi (||x-c_1||) + ... + f(x) = w_p \phi (||x-c_q||)

with phi as a radial basis function

