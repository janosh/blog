---
title: Two-Loop Hyperparameter Optimization
slug: /two-loop-hyperopt
date: 2018-11-23
cover:
  img: bayesian-optimization.svg
  source: Ramraj Chandradevan
  url: https://towardsdatascience.com/shallow-understanding-on-bayesian-optimization-324b6c1f7083
tags:
  - Machine Learning
  - Python
  - Tutorial
  - Statistics
---

I recently started using [Scikit-Optimize](https://scikit-optimize.github.io/) (`skopt` for short) to run Bayesian optimization on the hyperparameters of a set of fully-connected neural networks. The hyperparameters I optimized were

- the number of dense layers $n_L$
- the optimizer's learning rate $r_l$
- the numbers of nodes in each layer $N_\text{n} = \{n_{\text{n},i}\}_{i=1}^{n_L}$
- the dropout rates for the Monte Carlo dropout layers preceding every dense layer $R_\text{d} = \{r_{\text{d},i}\}_{i=1}^{n_L}$
- the activation functions $A = \{a_i\}_{i=1}^{n_L}$ for each layer

Right there I had a use case that `skopt` doesn't appear to cover - at least not out of the box. The difficulty is that the last three items in the list depend on the value of the first one. That's an ill-posed optimization problem. We'd be trying to minimize a loss function $L_\theta$ -- in this case the mean squared error over the validation set -- parameterized by the vector $\vec\theta = (n_L, r_l, N_\text{n}, R_\text{d}, A)$ over a parameter space $\Scal$ which depends itself on the current parameters $\vec\theta$, i.e.

$$
\vec\theta_\text{min} = \argmin_{\vec\theta \in \Scal(\vec\theta)} \; L(\vec\theta).
$$

But of course the search space can't change while we're searching it! Luckily, there's a simple fix. We just split the problem into two separate minimizations by pulling everything that doesn't depend on the number of layers $n_L$ into an outer loop. Hence, two-loop hyperoptimization. This yields

$$
\vec\theta_\text{min} = \argmin_{\vec\theta_1 \in \Scal_1} \; \argmin_{\vec\theta_2 \in \Scal_2(\vec\theta_1)} \; L(\vec\theta_1, \vec\theta_2),
$$

where $\vec\theta = (\vec\theta_1,\vec\theta_2)$ with $\vec\theta_1 = (n_L, r_l)$ and $\vec\theta_{2,i} = (N_\text{n}, R_\text{d}, A)$. The full search space is then given by $\Scal = \Scal_1 \cup \bigcup_{\vec\theta_1 \in \Scal_1} \Scal_2(\vec\theta_1)$.

Implemented in Python it doesn't look quite as pretty any more. To some degree that is because `skopt` insists on calling its objective function with a single argument, namely a list of the current set of hyperparameters. That means bringing in any additional arguments as required in this case to access the current parameters of the outer loop inside the inner one requires some workaround. The best I could come up with is some slightly verbose currying. See for yourself:

```python
import keras
import numpy as np
import skopt
from skopt.space import Categorical, Integer, Real

from .cross_val import cross_val

# iteration counter for the current outer and inner minimization loop
iter_counts = [1, 1]


def hyper_opt(model, data, n_calls=(10, 10), methods=["gp"], n_splits=3, verbose=False):
    """
    model: instance of Model class
    data: instance of Data class
    n_calls: 2-tuple of ints, number of iterations for the (outer, inner) minimization loop
    methods: list of strings containing one or more of gp, dummy, forest
        specifies which of skopt's minimizers to try
    n_splits: int how many cross validations to perform, min=1
    """
    outer_space = [  # pun intended
        # number of layers
        Integer(1, 5, name="n_layers"),
        # optimizer's learning rate
        Real(1e-5, 1e-4, "log-uniform", name="learning_rate"),
    ]

    def curried_inner_objective(n_layers, learning_rate):
        def inner_objective(inner_hypars):
            # unpack inner/outer iteration counters (iic/oic) and total number of calls (inc/onc)
            oic, iic, onc, inc = iter_counts + list(n_calls)
            model.log(f"Hyper loop: outer {oic}/{onc}, inner {iic}/{inc}")
            iter_counts[1] += 1

            hypars = (n_layers, learning_rate) + inner_hypars
            loss = cross_val(model, data, hypars, n_splits=n_splits)

            if loss < model.min_loss:
                model.log(f"found new min loss {round(loss, 4)}")
                model.log(f"params: {hypars}")
                model.min_loss = loss
                model.best_hypars = hypar
                model.best_model = model.model
                model.save()

            keras.backend.clear_session()
            return loss

        return inner_objective

    def curried_outer_objective(method):
        def outer_objective(outer_hypars):

            n_layers, learning_rate = outer_hypars
            # number of nodes in each dense layer
            nodes = (Integer(10, 100, name=f"n_nodes_{i+1}") for i in range(n_layers))
            # fraction of dropped nodes in each dropout layer
            dropouts = (
                Real(0, 0.5, name=f"dropout_rate_{i+1}") for i in range(n_layers)
            )
            # list of activation functions for each dense layer
            activations = (
                Categorical(["tanh", "relu"], name=f"activation_{i+1}")
                for i in range(n_layers)
            )
            res = getattr(skopt, method + "_minimize")(
                curried_inner_objective(outer_hypars),
                (*nodes, *dropouts, *activations),
                n_calls=n_calls[1],
                random_state=0,
                verbose=verbose,
            )
            global iter_counts
            iter_counts = [iter_counts[0] + 1, 1]
            return res.fun

        return outer_objective

    for method in methods:
        res = getattr(skopt, method + "_minimize")(
            curried_outer_objective(method),
            outer_space,
            n_calls=n_calls[0],
            random_state=0,
            verbose=verbose,
        )
        setattr(model, method + "hyper_res", res)
        model.log(f"\n{method} hyper optimization results:\n{res}")
```
