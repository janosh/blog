import {
  cover_url,
  date_num,
  format_issued,
  project_logo,
  project_matches,
  site_routes,
  sort_oss_projects,
} from '#lib'
import { goto } from '$app/navigation'
import { page } from '$app/state'
import { posterior_pct } from '../src/routes/posts/geometric-bayes/bayes.js'
import { apply_theme_mode } from 'svelte-widgets/theme'
import { search_actions } from '#lib/search.js'
import { excerpt, excerpts } from '#lib/server/excerpt.js'
import { load as load_home } from '../src/routes/+page.server.js'
import { load as load_oss } from '../src/routes/open-source/+page.server.js'
import { load as load_posts } from '../src/routes/posts/+page.server.js'
import { load as load_post } from '../src/routes/posts/+layout.server.js'
import OpenSourcePage from '../src/routes/open-source/+page.svelte'
import OpenSource from '#lib/OpenSource.svelte'
import Posts from '../src/routes/posts/+page@.svelte'
import PostLayout from '../src/routes/posts/+layout.svelte'
import StructureDemo from '../src/routes/posts/new-dielectric-materials/StructureDemo.svelte'
import Layout from '../src/routes/+layout.svelte'
import { createRawSnippet, type ComponentProps } from 'svelte'
import { theme_init_script, Toc } from 'svelte-widgets'
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
vi.mock(`#lib/server/posts.js`, () => ({
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
vi.mock(`#lib/oss.yml`, () => ({
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

const snippet = (html: string) => createRawSnippet(() => ({ render: () => html }))
const render_layout = (html = ``) =>
  render(Layout, { props: { data: {}, params: {}, children: snippet(html) } })
const render_post = (data: ComponentProps<typeof PostLayout>[`data`]) =>
  render(PostLayout, {
    props: { data, params: {}, children: snippet(`<p>Post content</p>`) },
  }).body

it(`loads shared projects, sorted featured work, and matched post metadata`, () => {
  const { projects, recent_work } = load_home()
  const post_page = load_post({ route: { id: `/posts/example` } })
  expect(post_page.frontmatter).toMatchObject({ slug: `example` })
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
      body: { message: `Post /posts/missing not found`, status: 404 },
    }),
  )
  expect(projects[1].description).toMatch(
    /<h2\b[^>]*>title: Keep me[\s\S]*<p>After<\/p>/u,
  )
})

it.each([
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
    expect(body).toMatch(/aria-checked="true"[^>]*data-value="commits"/u)
    // only the project with a paper_key gets a Paper pill, linking its resolved URL
    expect(body.match(/<span>Paper<\/span>/gu)).toHaveLength(1)
    expect(body).toContain(`href="https://arxiv.org/abs/2401.00096v1"`)
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
  const { body, head } = render_layout(`<main>Example</main>`)
  expect(body).toContain(`<main>Example</main>`)
  // theme restored in <head> before first paint, not left to hydration
  expect(head).toContain(theme_init_script)
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

it.each([0, 1, 2])(
  `renders neighboring post links with wraparound at index %i`,
  (current_idx) => {
    const posts = [`first`, `middle`, `last`].map((slug) => ({
      ...load_posts().posts[0],
      slug,
      title: `${slug} post`,
    }))
    const body = render_post({ posts, frontmatter: posts[current_idx] })
    for (const neighbor_idx of [(current_idx + 2) % 3, (current_idx + 1) % 3]) {
      const { slug, title } = posts[neighbor_idx]
      expect(body).toContain(`href="${slug}"`)
      expect(body).toContain(title)
    }
  },
)

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
  [`physics`, `qft`, `banner.webp`, /banner.*\.webp$/],
  [`posts`, `hmc-intro`, `https://a.b/c`, /^https:\/\/a\.b\/c$/],
] as const)(`resolves cover %s/%s/%s`, (section, slug, img, expected) => {
  expect(cover_url(section, slug, img)).toMatch(expected)
})
it.each([
  // bundled logos resolve to the imported asset (inlined as a data URI when small)
  [
    { logo: `torch-sim-logo.svg`, url: `https://x.dev` },
    /^(?:data:image\/svg\+xml|\/.*torch-sim-logo)/,
  ],
  [{ logo: `https://a.b/logo.png`, url: `https://x.dev` }, /^https:\/\/a\.b\/logo\.png$/],
  [{ url: `https://x.dev` }, /^https:\/\/x\.dev\/favicon\.svg$/],
])(`resolves project logo %j`, (project, expected) => {
  expect(project_logo(project)).toMatch(expected)
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

it.each([
  [`MACE`, true],
  [`foundation model`, true],
  [`python`, true],
  [`strong`, false], // inside <strong> markup only
  [`https`, false], // URLs are not searchable
  [``, true],
])(`project search for %j matches=%s`, (query, expected) => {
  const project = {
    name: `MACE`,
    description: `<p>A <strong>foundation model</strong> at <a href="https://x.y">x</a></p>`,
    languages: [`Python`],
  }
  expect(project_matches(project, query)).toBe(expected)
  const { languages: _, ...no_languages } = project
  expect(project_matches(no_languages, query)).toBe(expected && query !== `python`)
})

it.each([
  [{ year: 2025 }, `2025`],
  [{ year: 2025, month: 1 }, `Jan 2025`],
  [{ year: 2024, month: 7, day: 17 }, `Jul 2024`],
  [{ year: 2023, month: 12 }, `Dec 2023`],
])(
  `formats publication date %j without inventing missing precision`,
  (issued, expected) => {
    expect(format_issued(issued)).toBe(expected)
  },
)

const render_head = (
  url: string,
  frontmatter?: App.PageData[`frontmatter`],
  data: App.PageData = {},
) => {
  Object.assign(page, {
    url: new URL(url),
    route: { id: new URL(url).pathname },
    data: { frontmatter, ...data },
  })
  return render_layout().head
}

it(`marks only posts as og:type article with publish date and tags`, () => {
  const post_head = render_head(`https://janosh.dev/posts/normalizing-flows`, {
    title: `Flows`,
    slug: `normalizing-flows`,
    cover: { img: `abstract-flow.svg` },
    date: `2026-09-01`,
    tags: [`TypeScript`],
  })
  expect(post_head).toContain(`<meta property="og:type" content="article"`)
  expect(post_head).toContain(
    `<meta property="article:published_time" content="2026-09-01"`,
  )
  expect(post_head).toContain(`<meta property="article:tag" content="TypeScript"`)
  expect(post_head).toContain(
    `content="https://janosh.dev/og/posts/normalizing-flows/abstract-flow.png"`,
  )

  const physics_head = render_head(`https://janosh.dev/physics/qft`, {
    title: `QFT`,
    slug: `qft`,
    cover: { img: `banner.webp` },
  })
  expect(physics_head).toContain(`/og/physics/qft/banner.jpg"`)
  for (const head of [physics_head, render_head(`https://janosh.dev/posts/missing`)]) {
    expect(head).toContain(`<meta property="og:type" content="website"`)
    expect(head).not.toContain(`article:`)
  }
  render_head(`https://janosh.dev/posts`) // restore the default mock page
})

it.each([
  [
    `---\ntitle: T\n---\n<script>\nlet x = 1\n</script>\n\n## Heading\n\nFirst *real* para.`,
    `First real para.`,
  ],
  [
    `import a from './a'\n\nSee [the docs](https://x.y) and \`code\`[^1] with snake_case.`,
    `See the docs and code with snake_case.`,
  ],
  [
    `- list item\n\n> quote\n\n![img](a.png)\n\n$$x$$\n\nProse $E = mc^2$ here.`,
    `Prose E = mc^2 here.`,
  ],
  [`${`word `.repeat(40)}end`, `${`word `.repeat(32).trim()}…`],
  [`# only a heading`, ``],
  [`x`.repeat(200), `${`x`.repeat(159)}…`], // no space to cut at
  [`{#if x}\n\nShown text.\n\n{/if}`, `Shown text.`],
  [`---\r\ntitle: T\r\n---\r\nCRLF frontmatter.`, `CRLF frontmatter.`],
  [`See [A](https://w.org/A_(b)) end.`, `See A end.`],
  [`${`ab `.repeat(52)}cd, efg`, `${`ab `.repeat(52)}cd…`], // no dangling comma
])(`excerpts the first prose paragraph of %j`, (markdown, expected) => {
  expect(excerpt(markdown)).toBe(expected)
})

it(`gives every post and physics page a description`, () => {
  expect(Object.keys(excerpts).length).toBeGreaterThan(20)
  for (const [route, text] of Object.entries(excerpts)) {
    expect(text, route).toMatch(/^[A-Z0-9].{20,159}$/u)
    expect(text, route).not.toMatch(/import |\]\(|\[\^|[{}\\]|&\w+;|[,;:]…$/u)
  }
})

it.each([
  [`https://janosh.dev/`, /Periodic Labs/u, true],
  [`https://janosh.dev/cv`, /^CV of Janosh/u, true],
  [`https://janosh.dev/posts`, /^Posts by Janosh/u, false],
  [`https://janosh.dev/posts/x`, /^Custom$/u, false], // frontmatter description wins
])(
  `describes %s and embeds schema.org Person only on home and CV`,
  (url, desc, json_ld) => {
    const frontmatter = url.endsWith(`/x`)
      ? { title: `X`, slug: `x`, cover: { img: `a.svg` }, description: `Custom` }
      : undefined
    const head = render_head(url, frontmatter, json_ld ? load_home() : {})
    const { description } =
      /<meta name="description" content="(?<description>[^"]+)"/u.exec(head)?.groups ?? {}
    expect(description).toMatch(desc)
    expect(head).toContain(`<meta property="og:description" content="${description}"`)
    const { json } =
      /<script type="application\/ld\+json">(?<json>.+?)<\/script>/u.exec(head)?.groups ??
      {}
    expect(Boolean(json)).toBe(json_ld)
    if (json) {
      const person = JSON.parse(json)
      expect(person).toMatchObject({
        '@type': `Person`,
        worksFor: { name: `Periodic Labs` },
      })
      expect(person.sameAs).toContain(`https://orcid.org/0000-0001-5233-3462`)
      for (const link of person.sameAs) expect(link).toMatch(/^https:\/\//u)
    }
    render_head(`https://janosh.dev/posts`) // restore the default mock page
  },
)

it.each([
  [
    { origin: `Vecteezy`, url: `https://vecteezy.com/x` },
    `Cover: <a href="https://vecteezy.com/x">Vecteezy</a>`,
  ],
  [{ origin: `Alex Meyer` }, `Cover: Alex Meyer</small>`], // no url: plain text, no dead link
  [{}, undefined],
])(`credits cover source %j`, (credit, expected) => {
  const [post] = load_posts().posts
  const cover = { img: `https://example.com/cover.svg`, ...credit }
  const body = render_post({ posts: [post], frontmatter: { ...post, cover } })
  const html = body.replaceAll(/<!--[^>]*-->/gu, ``).replaceAll(/\s+/gu, ` `)
  if (expected) expect(html).toContain(expected)
  else expect(html).not.toContain(`Cover:`)
})
