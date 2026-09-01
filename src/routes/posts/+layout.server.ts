import { posts } from '$lib/server/posts'
import { error } from '@sveltejs/kit'

export function load({ route }: { route: { id: string | null } }) {
  const post = posts.find(({ slug }) => `/posts/${slug}` === route.id)
  if (!post) error(404, `Post ${route.id} not found`)
  return { posts, post }
}
