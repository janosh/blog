import { site_routes } from '$lib'
import { posts } from '$lib/server/posts'
import { homepage } from '$root/package.json'
import { GET as get_rss } from '$root/src/routes/rss.xml/+server'
import { GET as get_sitemap } from '$root/src/routes/sitemap.xml/+server'
import { load as load_post } from '$root/src/routes/posts/+layout.server'
import { load as load_physics } from '$root/src/routes/physics/+layout.server'
import { expect, it } from 'vite-plus/test'

it.each([
  [`/posts/hmc-intro`, `/posts/%68mc-intro`, load_post, `post`],
  [`/physics/qft`, `/physics/%71ft`, load_physics, `frontmatter`],
] as const)(
  `resolves %s from its matched route, including encoded URLs`,
  (id, path, load, key) => {
    const event = { route: { id }, url: new URL(`https://janosh.dev${path}`) }
    expect(load(event)).toHaveProperty(`${key}.slug`, id.split(`/`).at(-1))
  },
)

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
