---
title: What is renormalization?
slug: /what-is-renormalization
date: 2019-02-23
cover:
  img: magnifying-glasses.svg
  source: Vecteezy
  url: https://vecteezy.com/vector-art/137884-lupa-colorful-vector
tags:
  - Physics
  - Science
---

I want to give an intuitive understanding of the process of **renormalization** and why its useful. But to that, I first need to introduce the context in which the need for renormalization arose: **quantum field theory**, or QFT for short. For that I'll be [borrowing heavily from the always-excellent David Tong](http://damtp.cam.ac.uk/user/tong/whatisqft.html).

## What is QFT?

We are taught in school that fundamental particles such as electrons and quarks are like Lego bricks in that they constitute the basic building blocks out of which our reality, specifically all matter within it, is made. But below this statement lies a deeper truth. According to our best laws of physics, nature is ultimately not comprised of discrete particles at all. Instead she arises as the complex interplay of continuous fluid-like substances, spread all throughout space. We call these objects fields. The most familiar examples are the electric and magnetic fields. Ripples in these fields is what we see as light - at least for a small range of wavelengths.

But why is it called _quantum_ field theory? Quantum just means a discrete amount of something. It explains how particles emerge from their underlying fields. If you look closely but not too closely at electromagnetic waves, you'll find that they are made out of particles called photons. The ripples of the electric and magnetic fields get tied up into discrete bundles of energy once we include the effects of quantum mechanics. This same process is at play for all fields we know of; they are all quantized.

Despite QFT's discovery many decades ago, we are still a long way from understanding all its subtleties. Fully grasping QFT is hard because fields are very complicated objects. Not only because in their nature, they encode all of physics, but because fields can describe vast numbers of particles, interacting in unimaginably complex ways. These interactions depend not only on how many and what type of particles there are, but even how fast those particles are moving and how much they spin. Two electrons coming at each other experience a different interaction depending on whether their relative velocity is big or small.

This is only one aspect of a much bigger problem. With very few exceptions known as conformal field theories, all of physics is ultimately scale-dependent. Everything happening in nature can only be understood and correctly predicted if we account for the energy scale at which a process is occurring. Physicists realized this early in the quest to unravel and understand the mysteries of QFT. In response, they came up with intricate machinery for manipulating theories now known as renormalization.

## What is renormalization?

Renormalization is among the most powerful tools developed in the context of quantum field theory (QFT). It is essentially a complex recipe of instructions that allow physicists to have a single theory for any given process and then _renormalize_ it to the current conditions. It tells us how to adjust the values of the coupling constants relevant to that process to the energy at hand (e.g. the electric charge for two electrons interacting according to the laws of quantum electrodynamics). It has become an essential tool for particle physics and is used extensively, for instance when making predictions on the outcome of accelerator experiments. Since different accelerators achieve different energies, applying a one-size-fits-all theory would yield incorrect predictions.

There are by now multiple different avenues to pursue when attempting renormalize a given theory, similar to how a cake can be baked according to more than one recipe. One particular implementation of renormalization that is especially suited to statistical field theory and strongly interacting systems due to its non-perturbative nature [^1] is known as the functional renormalization group (FRG). It was spearheaded in the early 1990s by one of my thesis advisors in Heidelberg, Prof. Christof Wetterich. The FRG is built upon functional methods of quantum field theory combined with the intuitive interpretation of the renormalization group proposed by Kenneth Wilson. Wilson argued that the reason couplings shift and our theories need to be renormalized is that we are ignorant of the correct microscopic degrees of freedom and the laws governing their dynamics. Instead, our theories are only effective descriptions of reality valid down to some cutoff scale below which new physics emerges. In all our theories the true microscopic degrees of freedom are integrated out up to the smallest scale accessible to us. Hence they must be adjusted by further integrating out or recovering the small-scale degrees of freedom as we move up or down the energy scale.

FRG allows us to interpolate smoothly between known microscopic laws and the complicated collective phenomena in macroscopic physical systems. Figuratively speaking, FRG acts as a microscope with a variable resolution. At high-resolution, we observe the microphysical laws whereas dialing to a low resolution allows us to obtain a coarse-grained picture of macroscopic collective phenomena. In this sense, it marks the amazing achievement of enabling us to cross the bridge from simple microphysics to complex macrophysics, thereby helping us understand how particular features of the former manifest as behavior in the latter.

[^1]: Meaning it does not rely on expanding interactions into a power series of a small coupling constant.
