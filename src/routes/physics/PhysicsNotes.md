<script lang="ts">
  import { bugs } from '$root/package.json'
  import { Icon } from 'svelte-widgets'
  import { Atom } from 'svelte-widgets/icons'
</script>

<img src="./planets.svg" alt="Planets orbiting in an ultraviolet galaxy" class="banner" />

<section>
  <h2 id="notes-on-physics" class="section-title">
    <Icon icon={Atom} /> Notes on Physics
  </h2>

This is a compilation of notes and solutions to problem sheets for some of the physics lectures I took, most of them in <a href="https://www.uni-heidelberg.de/en" target="_blank" rel="noopener">Heidelberg</a>. Hopefully, they can be useful to others. If you find errors, please <a href={bugs} target="_blank" rel="noopener">open an issue</a>.

</section>

<div class="docs-grid">

[String Theory ![Cross section of the quintic Calabi–Yau manifold](./string-theory/calabi-yau.webp)](physics/string-theory)

[QFT ![Feynman diagram of electron-quark scattering](./qft/electron-quark-scattering.webp)](physics/qft)

[Advanced QFT ![Standard model interactions](./advanced-qft/standard-model-interactions.webp)](physics/advanced-qft)

[General Relativity ![Cosmic microwave background](./general-relativity/sun-earth-spacetime.webp)](physics/general-relativity)

[Group Theory ![Rubik's cube](./group-theory/rubiks-cube.webp)](physics/group-theory)

[Numerical Simulations ![Double pendulum](./numerical-simulations/double-pendulum.webp)](physics/numerical-simulations)

[Atomic Physics ![Electron excitations in an atomic shell](./atomic-physics/excited-electrons.webp)](physics/atomic-physics)

[Statistical Physics ![Phase space trajectory](./statistical-physics/phase-space-trajectory.webp)](physics/statistical-physics)

[QFT + Strings ![Keep calm](./advanced-qft+strings/keep-calm.webp)](physics/advanced-qft+strings)

[Bachelor's Thesis ![Graphene band structure](./bachelors-thesis/graphene-band-structure.webp)](physics/bachelors-thesis)

[Master's Thesis ![Absolute value of Bose-Einstein distribution over complex plane](./masters-thesis/complex-bose-einstein-distribution.webp)](physics/masters-thesis)

[PhD Thesis ![Thesis cover](https://github.com/janosh/thesis/raw/main/figs/thesis-cover.svg)](physics/phd-thesis)

</div>

<style>
  section {
    text-align: center;
    max-width: 50em;
    margin: 2em auto 2em;
  }
</style>
