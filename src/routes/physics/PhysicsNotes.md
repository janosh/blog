<script lang="ts">
  import { bugs } from '#root/package.json'
  import { Icon } from 'svelte-widgets'
  import { Atom } from 'svelte-widgets/icons'
</script>

<img src="./planets.svg" alt="Planets orbiting in an ultraviolet galaxy" class="banner" />
<small class="credit">Banner: <a href="https://vecteezy.com/vector-art/190741-ultra-violet-galactic-background-free-vector">Vecteezy</a></small>

<section>
  <h2 id="notes-on-physics" class="section-title">
    <Icon icon={Atom} /> Notes on Physics
  </h2>

This is a compilation of notes and solutions to problem sheets for some of the physics lectures I took, most of them in <a href="https://www.uni-heidelberg.de/en" target="_blank" rel="noopener">Heidelberg</a>. Hopefully, they can be useful to others. If you find errors, please <a href={bugs} target="_blank" rel="noopener">open an issue</a>.

</section>

<div class="docs-grid topics">

[String Theory ![Hanson's cross-section of the quintic Calabi–Yau manifold](./string-theory/calabi-yau-quintic.webp)](/physics/string-theory)

[QFT ![Feynman diagram of electron-positron annihilation into a quark, antiquark and gluon](./qft/electron-positron-annihilation.svg)](/physics/qft)

[Advanced QFT ![One-loop running of the Standard Model gauge couplings](./advanced-qft/running-gauge-couplings.svg)](/physics/advanced-qft)

[General Relativity ![Flamm's paraboloid embedding of Schwarzschild spacetime with an orbit and a bent light ray](./general-relativity/curved-spacetime-embedding.webp)](/physics/general-relativity)

[Group Theory ![SU(3) weight diagram of the baryon octet](./group-theory/eightfold-way-baryon-octet.svg)](/physics/group-theory)

[Numerical Simulations ![Two double pendulums diverging from nearly identical initial conditions](./numerical-simulations/chaotic-double-pendulum.webp)](/physics/numerical-simulations)

[Atomic Physics ![Hydrogen energy levels with the Lyman, Balmer and Paschen series](./atomic-physics/hydrogen-spectral-series.svg)](/physics/atomic-physics)

[Statistical Physics ![Ising model magnetization with lattice snapshots below, at and above the critical temperature](./statistical-physics/ising-model-phase-transition.svg)](/physics/statistical-physics)

[QFT + Strings ![A particle worldline splitting at a vertex versus a smooth string worldsheet](./advanced-qft+strings/particle-vs-string-interactions.svg)](/physics/advanced-qft+strings)

[Bachelor's Thesis ![Moiré superlattice of graphene on hexagonal boron nitride](./bachelors-thesis/graphene-on-hbn-moire.webp)](/physics/bachelors-thesis)

[Master's Thesis ![Absolute value of the Bose-Einstein distribution over the complex plane](./masters-thesis/bose-einstein-distribution-3d.webp)](/physics/masters-thesis)

[PhD Thesis ![Thesis cover](https://github.com/janosh/thesis/raw/main/figs/thesis-cover.svg)](/physics/phd-thesis)

</div>

<style>
  section {
    text-align: center;
    max-width: 50em;
    margin: 2em auto;
  }
  /* local topic thumbnails are Typst diagrams from janosh/diagrams on transparent
     backgrounds; recolor them like that repo's dark previews, except the shaded
     Calabi-Yau render, which (like its preserve_colors source) keeps its colors */
  :global(html[data-theme='dark']) .topics :global(img:not([src^='http'], [src*='calabi-yau'])) {
    filter: invert(0.9) hue-rotate(180deg);
  }
  /* fill the grid column even when a diagram is narrower than it (docs-grid centers cards) */
  .topics :global(a) {
    width: 100%;
  }
</style>
