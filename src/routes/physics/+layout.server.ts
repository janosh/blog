import type { PageMeta } from '#lib/types.js'
import { error } from '@sveltejs/kit'

// `?metadata` reads frontmatter via a markdown parse, without Svelte-compiling the pages.
const pages = import.meta.glob<Omit<PageMeta, `slug`>>(`./*/+page.md`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?metadata',
  import: 'default',
  eager: true,
})

export const load = ({ route }: { route: { id: string | null } }) => {
  const slug = route.id?.split(`/`).at(-1)
  const metadata = pages[`./${slug}/+page.md`]
  if (!slug || !metadata) error(404, `Physics page ${route.id} not found`)
  return { frontmatter: { ...metadata, slug } }
}
