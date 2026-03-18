import oss from '$lib/oss.yml'
import type { FrontMatter } from '$lib/types.js'
import { author } from '$root/package.json'
import { compile } from 'mdsvex'

export const prerender = true

export async function load({ url }: { url: URL }) {
  const glob = import.meta.glob<{ metadata: FrontMatter }>(
    `./posts/*/+page.{md,svx,svelte}`,
    { eager: true },
  )
  const posts: FrontMatter[] = Object.entries(glob).map(([file, post]) => {
    const parts = file.split(`/`)
    return Object.assign({}, post.metadata, {
      slug: parts[2],
      path: `/${parts.slice(1, -1).join(`/`)}`,
      file,
    })
  })

  const post = posts.find((candidate_post) => candidate_post.path === url.pathname)
  const email = author.split(` <`)[1].split(`>`)[0]
  const projects = await Promise.all(
    oss.projects.map(async (project) => {
      const { code } = (await compile(project.description)) ?? {}
      if (code === undefined || code.length === 0) {
        throw new Error(`Failed to compile description for ${project.name}`)
      }
      return { ...project, description: code }
    }),
  )

  return { posts, post, email, oss: { ...oss, projects } }
}
