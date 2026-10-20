import { site_routes } from '#lib'
import { posts } from '#lib/server/posts.js'
import { homepage } from '../package.json'
import { GET as get_rss } from '../src/routes/rss.xml/+server.js'
import { GET as get_sitemap } from '../src/routes/sitemap.xml/+server.js'
import { GET as get_og } from '../src/routes/og/[section]/[slug]/[img]/+server.js'
import { load as load_post } from '../src/routes/posts/+layout.server.js'
import { load as load_physics } from '../src/routes/physics/+layout.server.js'
import { existsSync, globSync, readFileSync } from 'node:fs'
import sharp from 'sharp'
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

type OgEvent = Parameters<typeof get_og>[0]
const og_event = (params: OgEvent[`params`]) => ({ params }) as OgEvent

it(`renders every local SVG cover as PNG and WebP cover as 1200x630 JPEG og:image`, async () => {
  const physics = globSync(`src/routes/physics/*/+page.md`).map((file) => [
    `physics`,
    file.split(`/`).at(-2) ?? ``,
    /^ {2}img: (?<img>\S+)$/mu.exec(readFileSync(file, `utf8`))?.groups?.img ?? ``,
  ])
  const covers = [
    ...posts.map(({ slug, cover }) => [`posts`, slug, cover.img]),
    ...physics,
  ].filter(([, , img]) => /\.(?:svg|webp)$/u.test(img) && !img.startsWith(`http`))
  expect(covers.filter(([, , img]) => img.endsWith(`.webp`)).length).toBeGreaterThan(10)
  for (const [section, slug, img] of covers) {
    const og_img = img.replace(/\.svg$/u, `.png`).replace(/\.webp$/u, `.jpg`)
    const response = await get_og(og_event({ section, slug, img: og_img }))
    const { format, width, height } = await sharp(await response.arrayBuffer()).metadata()
    expect([format, response.headers.get(`content-type`)]).toEqual(
      img.endsWith(`.svg`) ? [`png`, `image/png`] : [`jpeg`, `image/jpeg`],
    )
    if (img.endsWith(`.webp`)) expect([width, height]).toEqual([1200, 630])
  }
  for (const img of [`y.png`, `y.jpg`, `banner.png`]) {
    await expect(
      get_og(og_event({ section: `physics`, slug: `qft`, img })),
    ).rejects.toMatchObject({ status: 404 })
  }
})

it(`ships a compiled PDF and card thumbnail next to every typeset physics note`, () => {
  const sources = globSync(`src/routes/physics/**/pdfs/*.typ`)
  expect(sources.length).toBeGreaterThan(0)
  const missing = sources.flatMap((typ) =>
    [
      typ.replace(/\.typ$/u, `.pdf`),
      typ.replace(`/pdfs/`, `/thumbnails/`).replace(/\.typ$/u, `.webp`),
    ].filter((path) => !existsSync(path)),
  )
  expect(missing).toEqual([])
})
