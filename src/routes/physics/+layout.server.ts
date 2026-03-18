import type { FrontMatter } from '$lib/types'
import { error } from '@sveltejs/kit'

export const load = ({ url }: { url: URL }) => {
  const modules = import.meta.glob<{ metadata: FrontMatter }>(`./*/+page.md`, {
    eager: true,
  })

  const available_paths = Object.keys(modules).join(`, `)
  const slug = url.pathname.split(`/`).at(-1)
  const path = `./${slug}/+page.md`
  if (slug === undefined || slug.length === 0 || !(path in modules)) {
    error(404, `couldn't resolve ${slug} from ${available_paths}`)
  }

  const frontmatter = { ...modules[path].metadata, path, slug }

  return { frontmatter }
}
