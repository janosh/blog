import { describe } from '#lib/server/excerpt.js'
import { posts } from '#lib/server/posts.js'
import type { PostMeta } from '#lib/types.js'
import { error } from '@sveltejs/kit'

export function load({ route }: { route: { id: string | null } }) {
  const frontmatter = posts.find(({ slug }) => `/posts/${slug}` === route.id)
  if (!frontmatter) error(404, `Post ${route.id} not found`)
  const post: PostMeta = { ...frontmatter, description: describe(`posts`, frontmatter) }
  return { posts, frontmatter: post }
}
