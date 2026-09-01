import { date_num } from '$lib'
import oss from '$lib/oss.yml'
import papers from '$lib/papers.yaml'
import { projects } from '$lib/server/oss'

// featured projects and the PhD thesis as one date-sorted list for Recent Work
const recent_work = [
  ...oss.projects
    .filter((proj) => proj.featured)
    .map(({ name, url, logo, color_invert, description, paper_key, repo }) => {
      const paper = papers.references.find((ref) => ref.id === paper_key)
      if (!paper) throw new Error(`Paper ${paper_key} for ${name} not found`)
      return {
        name,
        url,
        logo,
        color_invert,
        description,
        issued: paper.issued[0],
        links: [
          { label: `Paper`, href: paper.URL },
          { label: `Code`, href: repo },
        ],
      }
    }),
  {
    name: `PhD Thesis`,
    url: `/physics/phd-thesis`,
    logo: `https://github.com/janosh/thesis/raw/main/figs/cambridge-crest.svg`,
    color_invert: undefined,
    description: `Towards Machine Learning Foundation Models for Materials Chemistry — Matbench Discovery, ML-guided dielectric discovery and the MACE-MP foundation model.`,
    issued: { year: 2024 },
    links: [
      { label: `PDF`, href: `https://doi.org/10.17863/CAM.113233` },
      { label: `Notes`, href: `/physics/phd-thesis` },
    ],
  },
].toSorted((card_1, card_2) => date_num(card_2.issued) - date_num(card_1.issued))

export const load = () => ({ projects, recent_work })
