import type { FrontMatter } from '$lib/types'

// Frontmatter of every blog post, newest first. Server-only so the markdown modules
// never end up in the client bundle.
const modules = import.meta.glob<{ metadata: FrontMatter }>(
  `/src/routes/posts/*/+page.md`,
  { eager: true },
)

export const posts: FrontMatter[] = Object.entries(modules)
  .map(([file, post]) => ({ ...post.metadata, slug: file.split(`/`)[4] }))
  .toSorted((post_1, post_2) => post_2.date.localeCompare(post_1.date))
