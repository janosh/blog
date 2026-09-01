import type { FrontMatter } from '$lib/types'
import { error } from '@sveltejs/kit'

export const load = ({ route }: { route: { id: string | null } }) => {
  const modules = import.meta.glob<{ metadata: FrontMatter }>(`./*/+page.md`, {
    eager: true,
  })

  const slug = route.id?.split(`/`).at(-1)
  const module = modules[`./${slug}/+page.md`]
  if (!slug || !module) {
    error(404, `couldn't resolve ${slug} from ${Object.keys(modules).join(`, `)}`)
  }

  return { frontmatter: { ...module.metadata, slug } }
}
