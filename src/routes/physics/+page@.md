---
title: Physics
cover:
  img: planets.svg
  origin: Vecteezy
  url: https://vecteezy.com/vector-art/190741-ultra-violet-galactic-background-free-vector
---

<script lang="ts">
  import { DocsGrid } from '$lib'
  import { issues } from '$root/package.json'
  import Icon from '@iconify/svelte'
</script>

<img src="./planets.svg" alt={cover.caption} class="banner" />

<h2 class="section-title">
  <Icon inline icon="mdi:atom" />
  Notes on Physics
</h2>

This is a compilation of notes and solutions to problem sheets for some of the physics lectures I took, most of them in [Heidelberg](https://google.com/search?q=Heidelberg). Hopefully, they can be useful to others. If you find errors, please [open an issue]({issues}).

<DocsGrid style="max-width: var(--body-max-width); margin: 0 auto 5em;">

[String Theory ![Cross section of the quintic Calabi–Yau manifold](./string-theory/calabi-yau.png)](physics/string-theory)

[QFT ![Feynman diagram of electron-quark scattering](./qft/electron-quark-scattering.png)](physics/qft)

[Advanced QFT ![Standard model interactions](./advanced-qft/standard-model-interactions.png)](physics/advanced-qft)

[General Relativity ![Cosmic microwave background](./general-relativity/sun-earth-spacetime.jpg)](physics/general-relativity)

[Group Theory ![Rubik's cube](./group-theory/rubiks-cube.png)](physics/group-theory)

[Numerical Simulations ![Double pendulum](./numerical-simulations/double-pendulum.jpg)](physics/numerical-simulations)

[Atomic Physics ![Electron excitations in an atomic shell](./atomic-physics/excited-electrons.png)](physics/atomic-physics)

[Statistical Physics ![Phase space trajectory](./statistical-physics/phase-space-trajectory.png)](physics/statistical-physics)

[QFT + Strings ![Keep calm](./advanced-qft+strings/keep-calm.png)](physics/advanced-qft+strings)

[Bachelor's Thesis ![Graphene band structure](./bachelors-thesis/graphene-band-structure.png)](physics/bachelors-thesis)

[Master's Thesis ![Absolute value of Bose-Einstein distribution over complex plane](./masters-thesis/complex-bose-einstein-distribution.png)](physics/masters-thesis)

</DocsGrid>

<style>
  p {
    max-width: 50em;
    margin: 1em auto;
  }
</style>
