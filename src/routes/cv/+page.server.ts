import { projects } from '#lib/server/oss.js'
import { publications } from '#lib/server/papers.js'
import { date_num } from '#lib'
import cv from './cv.yml'

export const load = () => ({
  projects: cv.selected_projects.map((selection) => {
    const project = projects.find(({ name }) => name === selection.name)
    if (!project) throw new Error(`Unknown CV project: ${selection.name}`)
    return { ...project, ...selection }
  }),
  publications: cv.selected_publications.map((id) => {
    const publication = publications.find((paper) => paper.id === id)
    if (!publication) throw new Error(`Unknown CV publication: ${id}`)
    return publication
  }),
  other_publications: publications
    .filter(({ id }) => !cv.selected_publications.includes(id))
    .toSorted((first, second) => date_num(second.issued) - date_num(first.issued)),
})
