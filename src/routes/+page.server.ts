import type { PageServerLoad } from './$types'

export const load: PageServerLoad = async () => {
  const posts = Object.entries(
    // eslint-disable-next-line @typescript-eslint/quotes
    import.meta.glob('./posts/*/+page.{md,svx,svelte}', { eager: true })
  ).map(([path, post]) => ({ ...post.metadata, slug: path.split(`/`)[2] }))

  for (const post of posts) {
    const { default: src } = await import(
      /* @vite-ignore */
      `./posts/${post.slug}/${post.cover.img}`
    )

    post.cover.src = src
  }

  return { posts }
}
