import { posts } from '#lib/server/posts.js'
import { error } from '@sveltejs/kit'

export function load({ route }: { route: { id: string | null } }) {
  const frontmatter = posts.find(({ slug }) => `/posts/${slug}` === route.id)
  if (!frontmatter) error(404, `Post ${route.id} not found`)
  return { posts, frontmatter }
}
