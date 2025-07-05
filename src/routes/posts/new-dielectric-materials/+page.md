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
  import { references } from '$lib/papers.yaml'
  import { projects } from '$lib/oss.yml'
  import { Structure } from 'matterviz'

  const diel_paper = references.find((ref) => ref.id === `riebesell_discovery_2024`)
  const matterviz = projects.find((proj) => proj.name === `MatterViz`)

  const structs = import.meta.glob(`./*.json`, { eager: true, import: 'default' })
</script>

[We just published data on two materials]({diel_paper.URL}), Zr<sub>2</sub>Bi<sub>2</sub>O<sub>7</sub> and CsTaTeO<sub>6</sub>, which were the result of a workflow to discover new dielectric materials. Dielectrics are in used CPUs and SSDs among many other electronic devices. We managed to experimentally synthesize both these materials and measure their dielectric properties (thanks Wes!), so I wanted to take the opportunity of having two crystal structures that are special to me to write a short tutorial on how to render 3D crystal structures in a browser using one of my side-projects called [`matterviz`]({matterviz.repo}).

`matterviz` currently only understands `pymatgen`'s JSON-like structure representation. Converting the experimental CIF files to this format is easy:

```py
from glob import glob

import pymatgen.transformations.advanced_transformations as pat
from pymatgen.core import Structure

for cif_file in glob("*.cif"):
    struct = Structure.from_file(cif_file).add_oxidation_state_by_guess()
    # remove partial occupancies, matterviz does not support them (yet)
    ordered = pat.OrderDisorderedStructureTransformation().apply_transformation(struct)
    ordered.to(cif.replace(".cif", ".json"))
```

The resulting JSON files can then be visualized with `matterviz` using the `Structure` component which takes only a few lines of code:

```svelte
<script>
  import { Structure } from 'matterviz'

  // parse all JSON files in this directory
  const structs = import.meta.glob(`./*.json`, { eager: true, import: 'default' })
</script>

<!-- iterate over JSON objects and pass them to the <Structure /> component for rendering -->
{#each Object.entries(structs) as [name, structure]}
  <Structure {structure} />
{/each}
```

Here's what this code renders:

<div style="display: grid; gap: 1em;">
  {#each Object.entries(structs) as [name, structure]}
    {@const [formula, spacegroup] = name.match(/\.\/(.+)-(.+)\.json/).slice(1)}
    <Structure {structure} show_bonds={false} />
  {/each}
</div>

Note the structures are rendered without bonds. That's because the converted CIFs give us `pymatgen` `Structures`, not `StructureGraphs` which contain adjacency matrices to convey bond information. `matterviz` can render bonds but `StructureGraph` support (i.e. converting the adjacency matrix into a list of bonds) is still WIP. While `matterviz` contains JS code for on-the-fly bond detection (based on max distance or nearest neighbor heuristics), it doesn't work well in many cases (don't use it). Hopefully something I'll fix soon.
