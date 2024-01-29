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
  import { Structure, StructureCard } from 'elementari'

  const diel_paper = references.find((ref) => ref.id === `riebesell_pushing_2024`)
  const elementari = projects.find((proj) => proj.name === `Elementari`)

  const structs = import.meta.glob(`./*.json`, { as: `raw`, eager: true })
</script>

[We just published data on two materials]({diel_paper.URL}), Zr<sub>2</sub>Bi<sub>2</sub>O<sub>7</sub> and CsTaTeO<sub>6</sub>, which were the result of a workflow to discover new dielectric materials. Dielectrics are in used CPUs and SSDs among many other electronic devices. We managed to experimentally synthesize both these materials and measure their dielectric properties (thanks Wes!), so I wanted to take the opportunity of having two crystal structures that are special to me to write a short tutorial on how to render 3D crystal structures in a browser using one of my side-projects called [`elementari`]({elementari.repo}).

`elementari` currently only understands `pymatgen`'s JSON-like structure representation. Converting the CIF files you get from (of the structures we verified with [XRD](https://wikipedia.org/wiki/X-ray_crystallography) to have made in the lab) to this format is easy:

```py
from glob import glob

import pymatgen.transformations.advanced_transformations as pat
from pymatgen.core import Structure

for cif in glob("*.cif"):
    struct = Structure.from_file(cif).add_oxidation_state_by_guess()
    # remove partial occupancies, elementari does not support them (yet)
    ordered = pat.OrderDisorderedStructureTransformation().apply_transformation(struct)
    ordered.to(cif.replace(".cif", ".json"))
```

The resulting JSON files can then be visualized with `elementari` using the `Structure` component which again takes only half a dozen lines of code:

```svelte
<script>
  import { Structure, StructureCard } from 'elementari'

  const structs = import.meta.glob(`./*.json`, { as: `raw`, eager: true })
</script>

{#each Object.entries(structs) as [name, json_struct]}
  {@const structure = JSON.parse(json_struct)}
  <StructureCard {structure} />
  <Structure {structure} />
{/each}
```

Here's what this code renders:

<div style="display: grid; gap: 1em;">
  {#each Object.entries(structs) as [name, json_struct]}
    {@const structure = JSON.parse(json_struct)}
    {@const [formula, spacegroup] = name.match(/\.\/(.+)-(.+)\.json/).slice(1)}
    <section>
      <StructureCard {structure} title="{formula} (<small>{spacegroup}</small>)" />
      <Structure {structure} show_bonds={false} show_site_labels />
    </section>
  {/each}
</div>

Note that the converted CIFs give us `pymatgen` `Structures`, not `StructureGraphs` which contain adjacency matrices to convey bond information. `elementari` can render bonds but `StructureGraph` support is still WIP and the JS code I wrote for on-the-fly bond detection is terrible (don't use it). Hopefully, something I'll fix in the coming months.
