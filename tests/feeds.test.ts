import { site_routes } from '#lib'
import { posts } from '#lib/server/posts.js'
import { homepage } from '../package.json'
import { GET as get_rss } from '../src/routes/rss.xml/+server.js'
import { GET as get_sitemap } from '../src/routes/sitemap.xml/+server.js'
import { GET as get_og_png } from '../src/routes/og/[section]/[slug]/[img].png/+server.js'
import { load as load_post } from '../src/routes/posts/+layout.server.js'
import { load as load_physics } from '../src/routes/physics/+layout.server.js'
import { expect, it } from 'vite-plus/test'

it.each([
  [`/posts/hmc-intro`, load_post],
  [`/physics/qft`, load_physics],
] as const)(`resolves %s from its matched route and 404s unknown pages`, (id, load) => {
  expect(load({ route: { id } }).frontmatter).toMatchObject({
    slug: id.split(`/`).at(-1),
    title: expect.any(String),
    cover: { img: expect.stringMatching(/\.\w+$/u) },
  })
  expect(() => load({ route: { id: `${id}-missing` } })).toThrow(
    expect.objectContaining({ status: 404 }),
  )
})

it(`loads posts newest first with directory slugs`, () => {
  expect(posts.length).toBeGreaterThan(10)
  expect(posts.map(({ slug }) => slug)).toContain(`hmc-intro`)
  const dates = posts.map(({ date }) => date)
  expect(dates).toEqual(dates.toSorted().toReversed())
})

it(`RSS lists posts with absolute links and escaped titles`, async () => {
  const response = get_rss()
  expect(response.headers.get(`Content-Type`)).toBe(`application/xml`)
  const xml = await response.text()
  expect(xml.startsWith(`<?xml version="1.0"`)).toBe(true)
  expect(xml.match(/<item>/g)).toHaveLength(posts.length)
  for (const { slug, title } of posts) {
    expect(xml).toContain(`<link>${homepage}/posts/${slug}</link>`)
    expect(xml).toContain(
      `<title>${title.replaceAll(`&`, `&amp;`).replaceAll(`<`, `&lt;`)}</title>`,
    )
  }
  // stray unescaped ampersands would make the feed invalid XML
  expect(xml).not.toMatch(/&(?!amp;|lt;|gt;)/)
})

it(`sitemap lists page routes, with lastmod only on posts`, async () => {
  const xml = await get_sitemap().text()
  expect(xml.match(/<url>/g)).toHaveLength(site_routes.length)
  for (const route of site_routes) {
    expect(xml).toContain(`<loc>${homepage}${route}</loc>`)
  }
  expect(xml.match(/<lastmod>/g)).toHaveLength(posts.length)
  expect(xml).not.toContain(`undefined`)
})

type OgEvent = Parameters<typeof get_og_png>[0]
const og_event = (params: OgEvent[`params`]) => ({ params }) as OgEvent

it(`renders every local SVG cover as a PNG og:image and 404s unknown ones`, async () => {
  const svg_covers = [
    ...posts.map(({ slug, cover }) => [`posts`, slug, cover.img]),
    [`physics`, `string-theory`, `contour-map.svg`],
  ].filter(([, , img]) => img.endsWith(`.svg`) && !img.startsWith(`http`))
  expect(svg_covers.length).toBeGreaterThan(10)
  for (const [section, slug, img] of svg_covers) {
    const response = await get_og_png(og_event({ section, slug, img: img.slice(0, -4) }))
    expect(response.headers.get(`content-type`)).toBe(`image/png`)
    const bytes = new Uint8Array(await response.arrayBuffer())
    expect(new TextDecoder().decode(bytes.slice(1, 4))).toBe(`PNG`)
  }
  expect(() => get_og_png(og_event({ section: `posts`, slug: `x`, img: `y` }))).toThrow(
    expect.objectContaining({ status: 404 }),
  )
})
