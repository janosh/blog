import type { FrontMatter } from '$lib/types.js'
import { author } from '$root/package.json'
import type { LayoutServerLoad } from './$types'
export const prerender = true

export const load: LayoutServerLoad = ({ url }) => {
  const posts = Object.entries(
    import.meta.glob(`./posts/*/+page.{md,svx,svelte}`, { eager: true }),
  ).map(([file, post]) => ({
    ...post.metadata,
    slug: file.split(`/`)[2],
    path: `/` + file.split(`/`).slice(1, -1).join(`/`),
    file,
  })) as FrontMatter[]

  const post = posts.find((post) => post.path === url.pathname)

  const email = author.split(` <`)[1].split(`>`)[0]

  return { posts, post, email }
}
