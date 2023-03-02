export const prerender = true

export const load = async ({ url }) => {
  const posts = Object.entries(
    // eslint-disable-next-line @typescript-eslint/quotes
    import.meta.glob('./posts/*/+page.{md,svx,svelte}', { eager: true })
  ).map(([file, post]) => ({
    ...post.metadata,
    slug: file.split(`/`)[2],
    path: '/' + file.split(`/`).slice(1, -1).join(`/`),
    file,
  }))

  const post = posts.find((post) => post.path === url.pathname)

  return { posts, post }
}
