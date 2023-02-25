import { error } from '@sveltejs/kit'
import type { LayoutServerLoad } from './$types'

export const load: LayoutServerLoad = async ({ url, parent }) => {
  const modules = import.meta.glob(`./*/+page.{md,svx,svelte}`)
  const slug = url.pathname.split(`/`).at(-1)
  if (!slug) throw error(404, `no slug`)

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

  const slugs = Object.keys(modules).map((x) => x.split(`/`)[1])
  const { prev_slug, next_slug } = get_prev_next(slugs, slug)

  const prev_post = await modules[`./${prev_slug}/+page.md`]?.()
  const next_post = await modules[`./${next_slug}/+page.md`]?.()

  return {
    posts: parent(),
    post: page.metadata,
    prev: { slug: prev_slug, ...(prev_post.metadata ?? {}) },
    next: { slug: next_slug, ...(next_post.metadata ?? {}) },
  }
}

const get_prev_next = (slugs: string[], slug: string) => {
  const idx = slugs.findIndex((slg) => slg === slug)
  if (idx === -1) {
    throw error(404, `Page '${slug}' not found`)
  }
  // wrap around start/end of array
  const prev_idx = (idx - 1 + slugs.length) % slugs.length
  const next_idx = (idx + 1) % slugs.length

  const prev_slug = slugs[prev_idx]
  const next_slug = slugs[next_idx]

  return { prev_slug, next_slug }
}
