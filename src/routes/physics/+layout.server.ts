import { error } from '@sveltejs/kit'
import type { LayoutServerLoad } from './$types'

export const load: LayoutServerLoad = async ({ url }) => {
  const modules = import.meta.glob(`./*/+page.{md,svx,svelte}`)
  const slug = url.pathname.split(`/`).at(-1)

  const [path, resolver] = Object.entries(modules).find(([path]) => {
    const route = path.split(`/`)[1]
    return route == slug
  })

  const page = await resolver?.()

  if (!page?.metadata) {
    throw error(404, `couldn't resolve ${slug} from ${Object.keys(modules)}`)
  }

  page.metadata.path = path
  page.metadata.slug = slug

  return {
    frontmatter: page.metadata,
  }
}