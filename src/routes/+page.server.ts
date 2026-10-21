import { date_num } from '#lib'
import papers from '#lib/papers.yaml'
import { projects, render_description } from '#lib/server/oss.js'
import { person_json_ld } from '#lib/server/person.js'

const find_paper = (paper_key: string, name: string) => {
  const paper = papers.references.find((ref) => ref.id === paper_key)
  if (!paper) throw new Error(`Paper ${paper_key} for ${name} not found`)
  return paper
}
const dyna_mat = find_paper(`gawkowski_dynamat_2026`, `Dyna-Mat`)

// featured projects, papers without a project page and the PhD thesis as one date-sorted
// list for Recent Work
const recent_work = [
  // projects carry descriptions already rendered from oss.yml markdown
  ...projects
    .filter((proj) => proj.featured)
    .map(({ name, url, logo, color_invert, description, paper_key, repo }) => {
      if (!paper_key) throw new Error(`Featured project ${name} has no paper_key`)
      const paper = find_paper(paper_key, name)
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
    name: `Dyna-Mat`,
    url: dyna_mat.URL,
    logo: `dyna-mat-logo.svg`, // drawn after the trajectories in the paper's Fig. 1
    color_invert: undefined,
    description: await render_description(
      `First-principles MD benchmark testing foundation MLIPs on structural and dynamical observables at finite temperature. Powers the [MD leaderboard](https://matbench-discovery.materialsproject.org/benchmarks/md) on Matbench Discovery.`,
      `card:dyna-mat`,
    ),
    issued: dyna_mat.issued[0],
    links: [
      { label: `Paper`, href: dyna_mat.URL },
      {
        label: `Leaderboard`,
        href: `https://matbench-discovery.materialsproject.org/benchmarks/md`,
      },
    ],
  },
  {
    name: `PhD Thesis`,
    url: `/physics/phd-thesis`,
    logo: `cambridge-coat-of-arms.svg`,
    color_invert: undefined,
    description: await render_description(
      `[Benchmarking ML models](https://matbench-discovery.materialsproject.org) for materials discovery, [ML-guided dielectrics search](/posts/new-dielectric-materials) and the [MACE-MP](https://github.com/ACEsuit/mace-foundations) foundation model.`,
      `card:phd-thesis`,
    ),
    issued: { year: 2024 },
    links: [
      { label: `PDF`, href: `https://doi.org/10.17863/CAM.113233` },
      { label: `Notes`, href: `/physics/phd-thesis` },
    ],
  },
].toSorted((card_1, card_2) => date_num(card_2.issued) - date_num(card_1.issued))

// featured projects already have a Recent Work card, so the landing page's Open Source list
// skips them (the /open-source page still lists everything)
const other_projects = projects.filter((proj) => !proj.featured)

export const load = () => ({ projects: other_projects, recent_work, person_json_ld })
