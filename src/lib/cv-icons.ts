// Attach statically imported svelte-widgets glyphs to CV YAML rows so the bundler can
// tree-shake unused ones. Lookup keys are the YAML `name` fields.
import type { IconData } from 'svelte-widgets'
import {
  API,
  Bike,
  Camera,
  CLang,
  Climbing,
  Contact,
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
  Vitest,
} from 'svelte-widgets/icons'
import cv from '../routes/cv/cv.yml'

const SOCIAL_ICONS = {
  GitHub,
  'Google Scholar': GoogleScholar,
  LinkedIn,
  Email: Contact,
} as const satisfies Record<string, IconData>

const SKILL_ICONS = {
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
} as const satisfies Record<string, IconData>

const HOBBY_ICONS = {
  photography: Camera,
  hiking: Hiking,
  cycling: Bike,
  climbing: Climbing,
} as const satisfies Record<string, IconData>

const require_icon = (
  map: Record<string, IconData>,
  key: string,
  kind: string,
): IconData => {
  const icon = map[key]
  if (!icon) throw new Error(`No svelte-widgets glyph mapped for ${kind} "${key}"`)
  return icon
}

export const social = cv.social.map((entry) => ({
  ...entry,
  icon: require_icon(SOCIAL_ICONS, entry.name, `social`),
}))

export const skills = cv.skills.map((entry) => ({
  ...entry,
  // SVG logos skip the icon map; everything else must resolve to a glyph.
  icon: entry.svg ? undefined : require_icon(SKILL_ICONS, entry.name, `skill`),
}))

export const hobbies = cv.hobbies.map((entry) => ({
  ...entry,
  icon: require_icon(HOBBY_ICONS, entry.name, `hobby`),
}))
