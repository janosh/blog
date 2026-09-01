import { print_cv, sort_papers } from '$root/src/routes/cv'
import {
  extract_citations,
  prepare_publication,
  publications as source_publications,
} from '$lib/server/papers'
import type { Reference } from '$lib/types'
import papers from '$lib/papers.yaml'
import * as printing from 'svelte-widgets/print'
import { afterEach, expect, it, vi } from 'vite-plus/test'

afterEach(() => vi.useRealTimers())

it.each([
  [`date`, `asc`, `Delta,Charlie,Alpha,Bravo`],
  [`date`, `desc`, `Bravo,Alpha,Charlie,Delta`],
  [`author`, `asc`, `Charlie,Bravo,Alpha,Delta`],
  [`author`, `desc`, `Delta,Alpha,Bravo,Charlie`],
  [`first author`, `desc`, `Alpha,Delta,Charlie,Bravo`],
  [`first author`, `asc`, `Delta,Charlie,Bravo,Alpha`],
  [`title`, `asc`, `Alpha,Bravo,Charlie,Delta`],
  [`citations`, `desc`, `Charlie,Delta,Bravo,Alpha`],
] as const)(
  `sorts publications by %s %s without mutation`,
  (sort_by, order, expected) => {
    const publications = (
      [
        [`Delta`, `Zebra`, { year: 2024, month: 2, day: 1 }, 2],
        [`Alpha`, `Riebesell`, { year: 2025 }, 0],
        [`Charlie`, `Adams`, { year: 2024, month: 2, day: 20 }, 6],
        [`Bravo`, `Jones`, { year: 2025, month: 1, day: 2 }, 1],
      ] as const
    ).map(([title, first_author, issued, citations]) => ({
      title,
      first_author,
      issued,
      citations,
      is_first_author: first_author === `Riebesell`,
    }))
    const original = [...publications]
    expect(sort_papers(publications, sort_by, order).map(({ title }) => title)).toEqual(
      expected.split(`,`),
    )
    expect(publications).toEqual(original)
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
      expect(style.textContent).toContain(`.sort-controls { display: none !important }`)
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
    expect(publication.is_first_author).toBe(my_idx === 0)
    expect(publication.first_author).toBe(author[0].family)
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
  expect(publication.is_first_author).toBe(false)
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
