import { cover_url, date_num, site_routes, sort_oss_projects, when_visible } from '$lib'
import { goto } from '$app/navigation'
import { posterior_pct } from '$root/src/routes/posts/geometric-bayes/bayes'
import { apply_theme_mode } from 'svelte-widgets/theme'
import { search_actions } from '$lib/search'
import { load as load_home } from '../src/routes/+page.server'
import { load as load_cv } from '../src/routes/cv/+page.server'
import { load as load_oss } from '../src/routes/open-source/+page.server'
import { load as load_posts } from '../src/routes/posts/+page.server'
import { load as load_post } from '../src/routes/posts/+layout.server'
import Cv from '../src/routes/cv/+page.svelte'
import OpenSourcePage from '../src/routes/open-source/+page.svelte'
import OpenSource from '$lib/OpenSource.svelte'
import Posts from '../src/routes/posts/+page@.svelte'
import StructureDemo from '../src/routes/posts/new-dielectric-materials/StructureDemo.svelte'
import Layout from '../src/routes/+layout.svelte'
import { createRawSnippet } from 'svelte'
import { Toc } from 'svelte-widgets'
import { render } from 'svelte/server'
import { expect, it, vi } from 'vite-plus/test'

vi.mock(`$app/navigation`, () => ({ goto: vi.fn(), afterNavigate: vi.fn() }))
vi.mock(`$app/state`, () => ({
  page: { url: new URL(`https://janosh.dev/posts`), route: { id: `/posts` }, data: {} },
}))
vi.mock(import(`svelte-widgets`), async (import_original) => {
  const widgets = await import_original()
  return { ...widgets, Toc: vi.fn(widgets.Toc) }
})
vi.mock(import(`svelte-widgets/theme`), async (import_original) => ({
  ...(await import_original()),
  apply_theme_mode: vi.fn(),
}))
vi.mock(`$lib/server/posts`, () => ({
  posts: [
    {
      slug: `example`,
      title: `Example post`,
      date: `2026-09-01`,
      tags: [`TypeScript`],
      cover: { img: `https://example.com/cover.svg` },
    },
  ],
}))
vi.mock(`$lib/oss.yml`, () => ({
  default: {
    projects: [
      {
        name: `Separator`,
        repo: `separator`,
        description: `---\n\n**Visible**`,
        featured: true,
        paper_key: `batatia_foundation_2023`,
      },
      {
        name: `Header`,
        repo: `https://github.com/materialsproject#contributors`,
        description: `---\ntitle: Keep me\n---\nAfter`,
      },
    ],
  },
}))

it(`loads shared projects, sorted featured work, and matched post metadata`, () => {
  const { projects, recent_work } = load_home()
  const post_page = load_post({ route: { id: `/posts/example` } })
  expect(post_page.post).toMatchObject({ slug: `example` })
  expect(load_cv().projects).toBe(projects)
  expect(load_oss().projects).toBe(projects)
  expect(load_posts().top_tags).toEqual([{ label: `TypeScript`, count: 1 }])
  expect(recent_work.map(({ name }) => name)).toEqual([`PhD Thesis`, `Separator`])
  expect(recent_work[1]).toMatchObject({
    issued: { year: 2023, month: 12, day: 29 },
    links: [
      { label: `Paper`, href: `https://arxiv.org/abs/2401.00096v1` },
      { label: `Code`, href: `separator` },
    ],
  })
  expect(() => load_post({ route: { id: `/posts/missing` } })).toThrow(
    expect.objectContaining({
      status: 404,
      body: { message: `Post /posts/missing not found` },
    }),
  )
  expect(projects[1].description).toMatch(
    /<h2\b[^>]*>title: Keep me[\s\S]*<p>After<\/p>/u,
  )
})

it.each([
  [`CV`, () => render(Cv, { props: { data: load_cv(), params: {}, form: null } })],
  [
    `Open Source page`,
    () => render(OpenSourcePage, { props: { data: load_oss(), params: {}, form: null } }),
  ],
  [`Open Source component`, () => render(OpenSource, { props: load_oss() })],
] as const)(
  `%s renders Markdown without invalid paragraph nesting`,
  (_name, render_page) => {
    const { body } = render_page()
    expect(body).toContain(`<hr>\n<p><strong>Visible</strong></p>`)
    expect(body).not.toMatch(
      /<p\b[^>]*>\s*(?:<!--[\s\S]*?-->\s*)*<(?:p|div|hr|h[1-6]|ul|ol|table)\b/u,
    )
    expect(body).not.toContain(`#contributors/graphs/contributors`)
  },
)

it.each([false, true])(
  `releases the visibility observer after activation=%s`,
  (visible) => {
    const observe = vi.fn()
    const disconnect = vi.fn()
    const activate = vi.fn()
    let intersect = (_entries: { isIntersecting: boolean }[]) => {
      throw new Error(`Observer was not installed`)
    }
    vi.stubGlobal(
      `IntersectionObserver`,
      class {
        observe = observe
        disconnect = disconnect
        constructor(callback: typeof intersect, options: IntersectionObserverInit) {
          intersect = callback
          expect(options.rootMargin).toBe(`200px`)
        }
      },
    )
    const node = {} as HTMLElement
    const cleanup = when_visible(activate)(node)
    expect(observe).toHaveBeenCalledWith(node)
    intersect([{ isIntersecting: false }])
    expect(activate).not.toHaveBeenCalled()
    expect(disconnect).not.toHaveBeenCalled()
    if (visible) {
      intersect([{ isIntersecting: false }, { isIntersecting: true }])
      expect(activate).toHaveBeenCalledOnce()
      expect(disconnect).toHaveBeenCalledOnce()
    }
    cleanup?.()
    expect(disconnect).toHaveBeenCalledTimes(visible ? 2 : 1)
  },
)

it(`renders linkable structure headings before loading the 3D renderer`, () => {
  const { body } = render(StructureDemo, {
    props: { structure: { sites: [], charge: 0 }, title: `CsTaTeO6 (Fd-3m)` },
  })
  expect(body).toContain(`<h2 id="cstateo6-fd-3m">CsTaTeO6 (Fd-3m)</h2>`)
  expect(body).not.toContain(`<canvas`)
})

it(`keeps the persistent layout TOC responsive to heading changes`, () => {
  const { body } = render(Layout, {
    props: {
      data: {},
      params: {},
      children: createRawSnippet(() => ({ render: () => `<main>Example</main>` })),
    },
  })
  expect(body).toContain(`<main>Example</main>`)
  expect(Toc).toHaveBeenCalledWith(
    expect.anything(),
    expect.objectContaining({ dynamic: true }),
  )
})

it.each([
  [{ year: 0 }, 0],
  [{ year: 2024 }, 20240000],
  [{ year: 2024, month: 2 }, 20240200],
  [{ year: 2024, month: 2, day: 29 }, 20240229],
  [{ year: 2025, month: 1, day: 1 }, 20250101],
])(`sorts partial date %j as %i`, (date, expected) => {
  expect(date_num(date)).toBe(expected)
})

it(`defers post thumbnails and uses the title when no caption is available`, () => {
  const { body } = render(Posts, {
    props: { data: load_posts(), params: {}, form: null },
  })
  expect(body).toMatch(/<img[^>]*alt="Example post"[^>]*loading="lazy"/u)
})

const projects = [
  { name: `beta`, commits: 5, stars: 100 },
  { name: `Alpha`, commits: 50, stars: 10 },
  // org links have no repo to query, hence no commit/star counts
  { name: `gamma`, commits: undefined, stars: undefined },
  { name: `delta`, commits: 20, stars: 30 },
]
it.each([
  [`commits`, `desc`, [`Alpha`, `delta`, `beta`, `gamma`]],
  [`commits`, `asc`, [`gamma`, `beta`, `delta`, `Alpha`]],
  [`stars`, `desc`, [`beta`, `delta`, `Alpha`, `gamma`]],
  [`stars`, undefined, [`beta`, `delta`, `Alpha`, `gamma`]],
  [`name`, `asc`, [`Alpha`, `beta`, `delta`, `gamma`]],
  [`name`, `desc`, [`gamma`, `delta`, `beta`, `Alpha`]],
] as const)(`sorts projects by %s %s without mutation`, (sort_by, order, expected) => {
  const input = [...projects]
  expect(sort_oss_projects(input, sort_by, order).map(({ name }) => name)).toEqual(
    expected,
  )
  expect(input).toEqual(projects)
})

it.each([
  [`posts`, `hmc-intro`, `bell-curves.svg`, /bell-curves.*\.svg$/],
  [`physics`, `qft`, `lhc-atlas.webp`, /lhc-atlas.*\.webp$/],
  [`posts`, `hmc-intro`, `https://a.b/c`, /^https:\/\/a\.b\/c$/],
] as const)(`resolves cover %s/%s/%s`, (section, slug, img, expected) => {
  expect(cover_url(section, slug, img)).toMatch(expected)
})
it(`reports a missing cover and its directory`, () => {
  expect(() => cover_url(`posts`, `hmc-intro`, `nope.png`)).toThrow(
    `cover nope.png not found in src/routes/posts/hmc-intro`,
  )
})

it(`exposes unique page routes and working navigation/theme commands`, () => {
  expect(site_routes).toEqual(
    expect.arrayContaining([`/`, `/posts`, `/posts/hmc-intro`, `/physics/qft`, `/cv`]),
  )
  for (const route of site_routes) expect(route).toMatch(/^\/[\w+/-]*$/)
  expect(new Set(site_routes).size).toBe(site_routes.length)
  const themes = [`light`, `dark`, `system`]
  expect(search_actions.map(({ id }) => id)).toEqual([
    ...site_routes.map((route) => `route:${route}`),
    ...themes.map((theme) => `theme:${theme}`),
  ])
  for (const { action, label } of search_actions) action(label)
  expect(vi.mocked(goto).mock.calls).toEqual(site_routes.map((route) => [route]))
  expect(vi.mocked(apply_theme_mode).mock.calls).toEqual(themes.map((theme) => [theme]))
})

it.each([
  // p(H)=20%, p(E|H)=40%, p(E|¬H)=20%: 8 / (8 + 16) = 1/3
  [20, 40, 20, 100 / 3],
  // evidence equally likely under both hypotheses leaves the prior unchanged
  [30, 50, 50, 30],
  // evidence impossible under ¬H makes H certain
  [10, 60, 0, 100],
  // evidence impossible under H rules it out
  [10, 0, 60, 0],
  // no evidence area at all: 0 instead of NaN
  [50, 0, 0, 0],
  [0, 40, 0, 0],
])(
  `p(H)=%i p(E|H)=%i p(E|¬H)=%i -> %f`,
  (p_h, p_e_given_h, p_e_given_not_h, expected) => {
    expect(posterior_pct(p_h, p_e_given_h, p_e_given_not_h)).toBeCloseTo(expected, 10)
  },
)
