import { site_routes } from '$lib'
import { posts } from '$lib/server/posts'
import { homepage } from '$root/package.json'

export const prerender = true

export const GET = () => {
  const urls = site_routes.map((route) => {
    // posts carry a publication date, everything else is undated
    const post = posts.find(({ slug }) => route === `/posts/${slug}`)
    const lastmod = post ? `<lastmod>${post.date.split(`T`)[0]}</lastmod>` : ``
    return `<url><loc>${homepage}${route}</loc>${lastmod}</url>`
  })

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  ${urls.join(`\n  `)}
</urlset>`

  return new Response(sitemap, { headers: { 'Content-Type': `application/xml` } })
}
