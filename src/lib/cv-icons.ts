// Attach statically imported svelte-widgets glyphs to CV YAML rows so the bundler can
// tree-shake unused ones.
import type { IconData } from 'svelte-widgets'
import {
  API,
  Bike,
  Camera,
  Climbing,
  Cluster,
  Deno,
  Git,
  Hiking,
  MongoDB,
  NodeJs,
  Playwright,
  Python,
  PyTorch,
  React,
  Rust,
  Server,
  Svelte,
  TypeScript,
  Vite,
} from 'svelte-widgets/icons'
import cv from '../routes/cv/cv.yml'

// keys are the YAML `name` fields of skills and hobbies
const ICONS: Record<string, IconData> = {
  Python,
  TypeScript,
  Svelte,
  Git,
  REST: API,
  Slurm: Cluster,
  MongoDB,
  PyTorch,
  Rust,
  React,
  HPC: Server,
  'Node.js': NodeJs,
  Deno,
  Vite,
  Playwright,
  photography: Camera,
  hiking: Hiking,
  cycling: Bike,
  climbing: Climbing,
}

const with_icon = <EntryT extends { name: string }>(entry: EntryT) => {
  const icon: IconData | undefined = ICONS[entry.name]
  if (!icon) throw new Error(`No svelte-widgets glyph mapped for "${entry.name}"`)
  return { ...entry, icon }
}

export const hobbies = cv.hobbies.map(with_icon)
// skills with a logo file skip the icon map; everything else must resolve to a glyph
export const skill_groups = cv.skills.map(({ name, items }) => ({
  name,
  items: items.map((entry) =>
    entry.logo ? { ...entry, icon: undefined } : with_icon(entry),
  ),
}))
