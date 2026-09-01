import { posts } from '$lib/server/posts'
import { homepage } from '$root/package.json'

export const prerender = true

const escape_xml = (text: string) =>
  text.replaceAll(`&`, `&amp;`).replaceAll(`<`, `&lt;`).replaceAll(`>`, `&gt;`)

export const GET = () => {
  const items = posts.map(({ title, slug, date, tags }) => {
    const url = `${homepage}/posts/${slug}`
    const categories = tags.map((tag) => `<category>${escape_xml(tag)}</category>`)
    return `<item>
      <title>${escape_xml(title)}</title>
      <link>${url}</link>
      <guid>${url}</guid>
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
