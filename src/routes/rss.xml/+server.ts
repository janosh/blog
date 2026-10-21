import { describe } from '#lib/server/excerpt.js'
import { posts } from '#lib/server/posts.js'
import { homepage } from '#root/package.json'
import { escape_html } from 'svelte-widgets/utils'

export const prerender = true

export const GET = () => {
  const items = posts.map((post) => {
    const { title, slug, date, tags } = post
    const url = `${homepage}/posts/${slug}`
    const categories = tags.map((tag) => `<category>${escape_html(tag)}</category>`)
    return `<item>
      <title>${escape_html(title)}</title>
      <link>${url}</link>
      <guid>${url}</guid>
      <description>${escape_html(describe(`posts`, post))}</description>
      <pubDate>${new Date(date).toUTCString()}</pubDate>
      ${categories.join(``)}
    </item>`
  })

  const rss = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>janosh.dev</title>
    <link>${homepage}</link>
    <description>Posts by Janosh Riebesell on physics, machine learning, materials science and web development</description>
    <language>en</language>
    <atom:link href="${homepage}/rss.xml" rel="self" type="application/rss+xml" />
    ${items.join(`\n`)}
  </channel>
</rss>`

  return new Response(rss, { headers: { 'Content-Type': `application/xml` } })
}
