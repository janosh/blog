import cv from '../src/routes/cv/cv.yml'
import { readFileSync } from 'node:fs'
import * as icons from 'svelte-widgets/icons'
import oss from '#lib/oss.yml'
import papers from '#lib/papers.yaml'
import { load } from '../src/routes/+page.server.js'
import { expect, it } from 'vite-plus/test'

it(`derives the schema.org Person from the current job and alma maters`, () => {
  const { person_json_ld } = load()
  expect(person_json_ld).toContain(`"jobTitle":"${cv.experience[0].role}"`)
  expect(person_json_ld).toContain(`"name":"${cv.experience[0].organization}"`)
  for (const { uni } of cv.education) expect(person_json_ld).toContain(uni)
})

it(`only selects open-source projects listed in oss.yml for the CV PDF`, () => {
  const names = new Set(oss.projects.map(({ name }) => name))
  expect(cv.selected_projects.length).toBeGreaterThan(0)
  for (const { name } of cv.selected_projects) expect(names, name).toContain(name)
})

it(`names only existing logo files and svelte-widgets icons for the CV PDF`, () => {
  // cv.typ reads these by name, so a typo would only fail the typst build
  const yaml = readFileSync(`src/routes/cv/cv.yml`, `utf8`)
  const logos = [...yaml.matchAll(/^\s+logo: (?<file>\S+)$/gmu)].map(
    (match) => match.groups?.file,
  )
  const glyphs = [...yaml.matchAll(/^\s+icon: (?<name>\S+)$/gmu)].map(
    (match) => match.groups?.name,
  )
  expect(logos.length).toBeGreaterThan(10)
  expect(glyphs.length).toBeGreaterThan(10)
  for (const file of logos)
    expect(() => readFileSync(`src/lib/${file}`), file).not.toThrow()
  for (const name of glyphs) expect(Object.keys(icons), name).toContain(name)
})

it(`marks joint first authorship only on papers in papers.yaml`, () => {
  const ids = papers.references.map(({ id }) => id)
  expect(cv.joint_first_author.length).toBeGreaterThan(0)
  for (const id of cv.joint_first_author) expect(ids, id).toContain(id)
})
