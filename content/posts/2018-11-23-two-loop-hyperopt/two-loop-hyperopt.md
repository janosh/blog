---
title: Two-Loop Hyperoptimization
slug: two-loop-hyperopt
date: 2018-11-23
cover: ./images/bayesian-optimization.png
tags:
  - Machine Learning
  - Data Science
  - Bayesian Methods
  - Tutorial
---

I recently started using [Scikit-Optimize](https://scikit-optimize.github.io/) (or `skopt` for short) for hyperoptimizing a bunch of fully-connected neural networks. Overall, it's been a very helpful tool! The hyperparameters I wanted to optimize were

- the number of layers $n_\text{l}$
- the optimizer's learning rate $r_l$
- the number of nodes per layer $n_{\text{n},i}$
- the dropout rate for the Monte Carlo dropout layers inserted after every dense layer $r_{\text{d},i}$
- each layers activation function $a_i$

where in each case $i \in \{1,\dots,n_\text{l}\}$. And right there I had a use case that `skopt` doesn't appear to cover - at least not out of the box. The difficulty is that the last three items in the list depend on the value of the first one. That's an ill-posed optimization problem. What that's asking is to minimize a loss function $L_\theta$ of some feature matrix $X$ parametrized by $\theta$ over a domain $\mathcal{D}$ which depends itself on the current parameters $\theta$, i.e.

$$
\theta_\text{min} = \underset{\theta \in \mathcal{D}(\theta)}{\arg \min} \; L_\theta(X).
$$

Luckily, there's a simple fix. We just split the problem into two separate minimizations by pulling everything that doesn't depend on the number of layers $n_\text{l}$ into an outer loop. Hence, two-loop hyperoptimization. This yields

$$
\theta_\text{min} = \underset{\theta_1 \in \mathcal{D}_1}{\arg \min} \; \underset{\theta_2 \in \mathcal{D}_2(\theta_1)}{\arg \min} \; L_{\theta_1 \theta_2}(X),
$$

where $\theta = (\theta_1,\theta_2)$ with $\theta_1 = (n_\text{l}, r_l)$, $\theta_2 = (n_{\text{n},i}, r_{\text{d},i}, a_i)$.

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
