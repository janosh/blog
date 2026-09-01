---
title: New Dielectric Materials
date: 2024-01-29
cover:
  img: dielectric-banner.svg
  origin: Vecteezy
  url: https://vecteezy.com/vector-art/192230-robot-character-design
tags:
  - Tutorial
  - Python
---

<script>
  import papers from '$lib/papers.yaml'
  import oss from '$lib/oss.yml'
  import StructureDemo from './StructureDemo.svelte'

  const diel_paper = papers.references.find((ref) => ref.id === `riebesell_discovery_2024`)
  const matterviz = oss.projects.find((proj) => proj.name === `MatterViz`)

  const structs = import.meta.glob(`./*.json`, { eager: true, import: 'default' })
</script>

[We just published data on two materials]({diel_paper.URL}), Zr<sub>2</sub>Bi<sub>2</sub>O<sub>7</sub> and CsTaTeO<sub>6</sub>, which were the result of a workflow to discover new dielectric materials. Dielectrics are used in CPUs and SSDs among many other electronic devices. We managed to experimentally synthesize both these materials and measure their dielectric properties (thanks [Wes](https://scholar.google.com/citations?user=uqutLTYAAAAJ)!), so I wanted to take the opportunity of having two crystal structures that are special to me to write a short tutorial on how to render 3D crystal structures in a browser using one of my side-projects called [`matterviz`]({matterviz.repo}).

```svelte
<script>
  import { Structure } from 'matterviz/structure'

  // parse all JSON files in this directory
  const structs = import.meta.glob(`./*.json`, { eager: true, import: 'default' })
</script>

<!-- iterate over JSON objects and pass them to the <Structure /> component for rendering -->
{#each Object.entries(structs) as [name, structure]}
  <Structure {structure} />
{/each}
```

Here's what this code renders:

<div style="display: grid; gap: 3em; margin-top: 2em;">
  {#each Object.entries(structs) as [name, structure]}
    {@const [formula, spacegroup] = name.match(/\.\/(.+)-(.+)\.json/).slice(1)}
    <StructureDemo {structure} title={`${formula} (${spacegroup})`} />
  {/each}
</div>
