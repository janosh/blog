import type { FrontMatter } from '$lib/types'
import { error } from '@sveltejs/kit'

export const load = ({ url }: { url: URL }) => {
  const modules = import.meta.glob<{ metadata: FrontMatter }>(`./*/+page.md`, {
    eager: true,
  })

  const slug = url.pathname.split(`/`).at(-1)
  const path = `./${slug}/+page.md`
  if (!slug || !(path in modules)) {
    throw error(404, `couldn't resolve ${slug} from ${Object.keys(modules).join(`, `)}`)
  }

  const frontmatter = { ...modules[path].metadata, path, slug }

  return { frontmatter }
}
