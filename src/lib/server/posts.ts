import type { PostMeta } from '#lib/types.js'

// Frontmatter of every blog post, newest first. `?metadata` reads it via a markdown
// parse, without Svelte-compiling or bundling the posts themselves.
const modules = import.meta.glob<Omit<PostMeta, `slug`>>(`/src/routes/posts/*/+page.md`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?metadata',
  import: 'default',
  eager: true,
})

export const posts: PostMeta[] = Object.entries(modules)
  .map(([file, metadata]) => ({ ...metadata, slug: file.split(`/`)[4] }))
  .toSorted((post_1, post_2) => post_2.date.localeCompare(post_1.date))
