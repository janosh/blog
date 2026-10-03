import { format_publication_date, print_cv } from '../src/routes/cv/index.js'
import {
  extract_citations,
  prepare_publication,
  publications as source_publications,
} from '#lib/server/papers.js'
import type { Reference } from '#lib/types.js'
import papers from '#lib/papers.yaml'
import cv from '../src/routes/cv/cv.yml'
import { load as load_cv } from '../src/routes/cv/+page.server.js'
import Cv from '../src/routes/cv/+page.svelte'
import Papers from '../src/routes/cv/Papers.svelte'
import { render } from 'svelte/server'
import * as printing from 'svelte-widgets/print'
import { afterEach, expect, it, vi } from 'vite-plus/test'

afterEach(() => vi.useRealTimers())

it(`renders curated work and keeps the remaining publications accessible without duplicates`, () => {
  const data = load_cv()
  expect(data.projects.map(({ name }) => name)).toEqual(
    cv.selected_projects.map(({ name }) => name),
  )
  expect(data.publications.map(({ id }) => id)).toEqual(cv.selected_publications)
  const { body } = render(Cv, { props: { data, params: {}, form: null } })
  const [selected_html, remaining_html] = body.split(`<details`)
  expect(remaining_html).toBeDefined()
  for (const { id } of data.publications) {
    expect(selected_html).toContain(`id="${id}"`)
    expect(remaining_html).not.toContain(`id="${id}"`)
  }
  for (const { id } of data.other_publications) {
    expect(selected_html).not.toContain(`id="${id}"`)
    expect(remaining_html).toContain(`id="${id}"`)
  }
  expect(data.publications.length + data.other_publications.length).toBe(
    source_publications.length,
  )
  expect(selected_html).toContain(`href="/open-source"`)
  expect(selected_html).not.toContain(`/stargazers`)
  for (const { role, contribution } of data.projects) {
    expect(selected_html).toContain(`${role}.</strong>`)
    expect(selected_html).toContain(contribution)
  }
  for (const { organization, dates } of cv.experience) {
    expect(selected_html).toContain(organization)
    expect(selected_html).toContain(dates)
  }
  for (const { name, items } of cv.skills) {
    expect(body).toContain(name)
    for (const skill of items) expect(body).toContain(skill.name)
  }
  expect(body).not.toMatch(/\((?:10|[0-9])\)<\/small>/u)
  expect(body).not.toContain(`Sort by`)
})

it.each([
  [{ year: 2025 }, `2025`],
  [{ year: 2025, month: 1 }, `Jan 2025`],
  [{ year: 2024, month: 7, day: 17 }, `Jul 2024`],
  [{ year: 2023, month: 12 }, `Dec 2023`],
])(
  `formats publication date %j without inventing missing precision`,
  (issued, expected) => {
    expect(format_publication_date(issued)).toBe(expected)
  },
)

it.each([
  [
    { DOI: `10.1234/example`, URL: `https://arxiv.org/abs/example` },
    `https://doi.org/10.1234/example`,
    `DOI`,
  ],
  [{ URL: `https://arxiv.org/abs/example` }, `https://arxiv.org/abs/example`, `preprint`],
  [{}, undefined, ``],
])(
  `links paper titles for %j and keeps identifiers out of the visible text`,
  (links, href, label) => {
    const publication = prepare_publication({ ...reference, ...links })
    const { body } = render(Papers, { props: { publications: [publication] } })
    const visible_text = body.replaceAll(/<[^>]*>/gu, ``)
    if (href) expect(body).toContain(`href="${href}"`)
    else expect(body).not.toContain(`href=`)
    expect(visible_text).toContain(`Example`)
    expect(visible_text).toContain(label)
    expect(visible_text).toContain(`2025`)
    expect(visible_text).not.toContain(`10.1234/example`)
    expect(visible_text).not.toContain(`https://`)
  },
)

it.each([
  `multi-page`,
  `afterprint`,
  `timeout`,
  `failure`,
  `measurement failure`,
  `single-then-multi`,
])(`prints the CV and cleans up page sizing: %s`, (mode) => {
  vi.useFakeTimers()
  vi.setSystemTime(new Date(`2026-09-07T12:00:00Z`))
  const style = { textContent: ``, media: ``, remove: vi.fn() }
  const append = vi.fn()
  const events = new EventTarget()
  const print_page = vi.spyOn(printing, `print_page`).mockImplementation(() => {
    if (mode !== `multi-page`) expect(style.media).toBe(`print`)
    if (mode === `failure`) throw new Error(`Printing unavailable`)
  })
  vi.stubGlobal(`document`, { createElement: () => style, head: { append } })
  vi.stubGlobal(`addEventListener`, events.addEventListener.bind(events))
  vi.stubGlobal(`removeEventListener`, events.removeEventListener.bind(events))
  const node = {
    getBoundingClientRect: () => {
      expect(append).toHaveBeenCalledWith(style)
      expect(style.media).toBe(``)
      expect(style.textContent).toContain(`padding: 2em !important`)
      if (mode === `measurement failure`) throw new Error(`Measurement unavailable`)
      return { height: 1200 }
    },
  } as HTMLElement
  if (mode.includes(`failure`))
    expect(() => print_cv(node, true)).toThrow(
      mode === `failure` ? `Printing unavailable` : `Measurement unavailable`,
    )
  else print_cv(node, mode !== `multi-page`)
  if (mode === `single-then-multi`) {
    expect(style.remove).not.toHaveBeenCalled()
    print_cv(node)
  }
  expect(print_page).toHaveBeenCalledTimes(
    mode === `measurement failure` ? 0 : mode === `single-then-multi` ? 2 : 1,
  )
  if (mode !== `measurement failure`)
    expect(print_page).toHaveBeenCalledWith({ filename: `janosh-cv-2026-09-07` })
  if (mode === `multi-page`) expect(append).not.toHaveBeenCalled()
  else {
    if (mode !== `measurement failure`) {
      expect(style.textContent).toContain(`@page { size: 210mm 318mm; margin: 0 }`)
      expect(style.textContent).toContain(`[data-cv] { width: 210mm`)
      expect(style.textContent).toContain(`overflow: visible`)
    }
    if (mode === `afterprint`) events.dispatchEvent(new Event(`afterprint`))
    if (mode === `timeout`) vi.advanceTimersByTime(60_000)
    expect(style.remove).toHaveBeenCalledOnce()
    events.dispatchEvent(new Event(`afterprint`))
    expect(style.remove).toHaveBeenCalledOnce()
  }
  expect(vi.getTimerCount()).toBe(0)
})

const reference: Reference = {
  id: `example`,
  title: `Example`,
  issued: [{ year: 2025 }],
  author: [{ given: `Janosh`, family: `Riebesell` }],
}

it.each([
  [`A,B`, 1, `A,me`],
  [`A,B,C`, 0, `me,B,C`],
  [`A,B,C,D,E`, 4, `A,B,...,me`],
  [`A,B,C,D,E`, 2, `A,...,me,...,E`],
  [`A,B,C,D,E`, 0, `me,B,...,E`],
  [`A,B,C,D,E`, 3, `A,...,me,E`],
  [`A,A,B,C,A`, 2, `A,...,me,...,A`],
])(
  `keeps first, self and last authors for %s with self at %i`,
  (families, my_idx, expected) => {
    const author = families
      .split(`,`)
      .map((family, idx) =>
        idx === my_idx ? reference.author[0] : { given: `Alice`, family },
      )
    const publication = prepare_publication({ ...reference, author })
    const names = publication.authors.map((visible_author) =>
      visible_author?.is_me ? `me` : (visible_author?.name.slice(3) ?? `...`),
    )
    expect(names.join(`,`)).toBe(expected)
    expect(publication.issued).toEqual({ year: 2025 })
  },
)

it.each([
  { author: [] },
  { author: [{ given: `Janosh`, family: `` }] },
  { author: [{ given: ``, family: `Riebesell` }] },
  { author: [{ given: `John`, family: `Riebesell` }] },
  { issued: [] },
  { issued: [{ year: NaN }] },
])(`rejects malformed publication %j with its ID`, (invalid) => {
  expect(() => prepare_publication({ ...reference, ...invalid })).toThrow(`example`)
})

it(`distinguishes authors with matching initials by their full names`, () => {
  const publication = prepare_publication({
    ...reference,
    author: [{ given: `John`, family: `Riebesell` }, ...reference.author],
  })
  expect(publication.authors).toEqual([
    { name: `J. Riebesell`, is_me: false },
    { name: `J. Riebesell`, is_me: true },
  ])
})

it(`prepares every YAML publication without raw bibliography metadata`, () => {
  expect(papers.references.length).toBeGreaterThan(0)
  expect(papers.references.every(({ id, title }) => id && title)).toBe(true)
  expect(source_publications).toHaveLength(papers.references.length)
  for (const publication of source_publications) {
    expect(publication.authors.filter((author) => author?.is_me)).toHaveLength(1)
    expect(publication.authors.filter(Boolean).length).toBeLessThanOrEqual(3)
    expect(publication).not.toHaveProperty(`author`)
    expect(publication).not.toHaveProperty(`note`)
  }
})

it.each([
  [undefined, 0, ``],
  [``, 0, ``],
  [`no citation info here`, 0, ``],
  [`Citations: 12 (Crossref)`, 12, `Crossref`],
  // Pick the largest count, retaining the first database when tied.
  [
    `Citations: 12 (Crossref); Citations: 40 (Semantic Scholar); Citations: 40 (Google Scholar)`,
    40,
    `Semantic Scholar`,
  ],
])(`extracts maximum citations from %j`, (note, citations, citation_database) => {
  expect(extract_citations(note)).toEqual({ citations, citation_database })
})
