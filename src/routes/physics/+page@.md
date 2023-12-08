---
title: Physics
cover:
  img: planets.svg
  source: Vecteezy
  url: https://vecteezy.com/vector-art/190741-ultra-violet-galactic-background-free-vector
---

<script lang="ts">
  import { DocsGrid } from '$lib'
  import { issues } from '$root/package.json'
</script>

<section class="landing">

<img src="./planets.svg" alt={cover.caption} />

<h2 class="section-title">Notes on Physics</h2>

This is a compilation of notes and solutions to problem sheets for some of the physics lectures I took, most of them in Heidelberg, Germany. Hopefully, they can be useful to others. If you find errors, please [open an issue]({issues}).

<DocsGrid>

[String Theory ![Cross section of the quintic Calabi–Yau manifold](./string-theory/calabi-yau.png)](physics/string-theory)

[QFT ![Feynman diagram of electron-quark scattering](./qft/electron-quark-scattering.png)](physics/qft)

[Advanced QFT ![Standard model interactions](./advanced-qft/standard-model-interactions.png)](physics/advanced-qft)

[General Relativity ![Cosmic microwave background](./general-relativity/sun-earth-spacetime.jpg)](physics/general-relativity)

[Group Theory ![Rubik's cube](./group-theory/rubiks-cube.png)](physics/group-theory)

[Numerical Simulations ![Double pendulum](./numerical-simulations/double-pendulum.jpg)](physics/numerical-simulations)

[Atomic Physics ![Electron excitations in an atomic shell](./atomic-physics/excited-electrons.png)](physics/atomic-physics)

[Statistical Physics ![Phase space trajectory](./statistical-physics/phase-space-trajectory.png)](physics/statistical-physics)

[QFT + Strings Oral exam ![Keep calm](./qft+strings-oral-exam/keep-calm.png)](physics/qft+strings-oral-exam)

[Bachelor's Thesis ![Graphene band structure](./bachelors-thesis/graphene-band-structure.png)](physics/bachelors-thesis)

[Master's Thesis ![Absolute value of Bose-Einstein distribution over complex plane](./masters-thesis/complex-bose-einstein-distribution.png)](physics/masters-thesis)

</DocsGrid>

</section>
