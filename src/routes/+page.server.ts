import type { PageServerLoad } from './$types'

export const load: PageServerLoad = () => {
  const posts = Object.entries(
    // eslint-disable-next-line @typescript-eslint/quotes
    import.meta.glob('./posts/*/+page.{md,svx,svelte}', { eager: true })
  ).map(([path, post]) => ({ ...post.metadata, slug: path.split(`/`)[2] }))

  return { posts }
}
