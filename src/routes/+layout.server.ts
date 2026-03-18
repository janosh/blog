import type { FrontMatter } from '$lib/types.js'
import { author } from '$root/package.json'
export const prerender = true

export const load = ({ url }: { url: URL }) => {
  const glob = import.meta.glob<{ metadata: FrontMatter }>(
    `./posts/*/+page.{md,svx,svelte}`,
    { eager: true },
  )
  const posts: FrontMatter[] = Object.entries(glob).map(([file, post]) => {
    const parts = file.split(`/`)
    return Object.assign({}, post.metadata, {
      slug: parts[2],
      path: `/` + parts.slice(1, -1).join(`/`),
      file,
    })
  })

  const post = posts.find((post) => post.path === url.pathname)

  const email = author.split(` <`)[1].split(`>`)[0]

  return { posts, post, email }
}
