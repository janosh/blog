---
title: 'Artificial Intelligence'
slug: 'ai'
purpose: 'page'
---

I'm currently working at Cambridge University's Maxwell Centre under the supervision of [Alpha Lee](https://alpha-lee.com) on applications of machine learning in physics.

![Maxwell Centre](./maxwell-centre.jpg)

More specifically, we recently started out on a project that aims to discover high figure of merit ($zT > 1$) and sustainable (lead-free and rare earth-free) bulk thermoelectrics using machine learning-guided experimentation. The key advance is going beyond 'big data' – both first principles calculations and experimental synthesis and characterisation of bulk thermoelectrics are costly and low throughput – and instead move towards 'optimal data' by developing novel algorithms that optimize thermoelectric performance ($z T$) with minimal number of expensive calculations and experiments.

To date there has been no statistically robust approach to simultaneously incorporate experimental and model error into machine learning models in a search space with high opportunity cost and high latency (i.e. large time between prediction and validation).

Consequently, searches have been unable to effectively guide experimentalists in the selection of exploring or exploiting new materials when the validation step is inherently low throughput and resource-intensive, such as the case of developing new bulk functional materials like thermoelectrics. This project will realize a holistic pipeline to discover novel thermoelectrics: machine learning is used to predict the $z T$ of a large database of structures together with predicted uncertainty. Candidate structures are then selected, based on maximizing $z T$ subjected to a tolerable level of uncertainty, to proceed to the next stage where expensive experimental synthesis and characterization of high-$z T$ candidates are guided by Bayesian optimization and active machine learning.

If you're interested, take a look at Alpha's [Github repo](https://github.com/alphaleegroup).
