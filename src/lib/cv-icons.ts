// Attach statically imported svelte-widgets glyphs to CV YAML rows so the bundler can
// tree-shake unused ones.
import type { IconData } from 'svelte-widgets'
import {
  API,
  Bike,
  Camera,
  CLang,
  Climbing,
  Deno,
  Git,
  GitHub,
  GoogleScholar,
  GraphQL,
  Hiking,
  LinkedIn,
  Mathematica,
  MongoDB,
  NodeJs,
  Playwright,
  Python,
  PyTorch,
  React,
  Rust,
  Svelte,
  TypeScript,
  Email,
  Vitest,
} from 'svelte-widgets/icons'
import cv from '../routes/cv/cv.yml'

// keys are the YAML `name` fields of social links, skills and hobbies
const ICONS: Record<string, IconData> = {
  GitHub,
  'Google Scholar': GoogleScholar,
  LinkedIn,
  Email,
  Python,
  TypeScript,
  Svelte,
  C: CLang,
  Git,
  Mathematica,
  REST: API,
  MongoDB,
  GraphQL,
  PyTorch,
  Rust,
  React,
  'Node.js': NodeJs,
  Deno,
  vitest: Vitest,
  PlayWright: Playwright,
  photography: Camera,
  hiking: Hiking,
  cycling: Bike,
  climbing: Climbing,
}

const require_icon = (name: string): IconData => {
  const icon: IconData | undefined = ICONS[name]
  if (!icon) throw new Error(`No svelte-widgets glyph mapped for "${name}"`)
  return icon
}

export const social = cv.social.map((entry) => ({
  ...entry,
  icon: require_icon(entry.name),
}))
export const hobbies = cv.hobbies.map((entry) => ({
  ...entry,
  icon: require_icon(entry.name),
}))
// SVG logos skip the icon map; everything else must resolve to a glyph
export const skills = cv.skills.map((entry) => ({
  ...entry,
  icon: entry.svg ? undefined : require_icon(entry.name),
}))
