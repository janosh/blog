import type { FrontMatter } from '$lib/types'
import { error } from '@sveltejs/kit'
import type { LayoutServerLoad } from './$types'

export const load: LayoutServerLoad = ({ url }) => {
  const modules = import.meta.glob(`./*/+page.md`, { eager: true })

  const slug = url.pathname.split(`/`).at(-1)
  const path = `./${slug}/+page.md`
  if (!slug || !(path in modules)) {
    throw error(404, `couldn't resolve ${slug} from ${Object.keys(modules)}`)
  }

  const frontmatter = modules[path]?.metadata as FrontMatter

  frontmatter.path = path
  frontmatter.slug = slug

  return { frontmatter }
}
