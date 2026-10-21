import { describe } from '#lib/server/excerpt.js'
import type { PageMeta } from '#lib/types.js'
import { repository } from '#root/package.json'
import { error } from '@sveltejs/kit'

// `?metadata` reads frontmatter via a markdown parse, without Svelte-compiling the pages.
const pages = import.meta.glob<Omit<PageMeta, `slug`>>(`./*/+page.md`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?metadata',
  import: 'default',
  eager: true,
})
// note PDFs and their first-page thumbnails as hashed asset URLs
const assets = import.meta.glob<string>(`./*/{pdfs,thumbnails}/*.{pdf,webp}`, {
  query: '?url',
  import: 'default',
  eager: true,
})
// only the keys are used (which notes have Typst sources); the lazy imports never run
const sources = new Set(
  Object.keys(import.meta.glob(`./*/pdfs/*.typ`, { query: '?raw' })),
)

export type Note = { pdf: string; thumbnail: string; source?: string }

export const load = ({ route }: { route: { id: string | null } }) => {
  const slug = route.id?.split(`/`).at(-1)
  const metadata = pages[`./${slug}/+page.md`]
  if (!slug || !metadata) error(404, `Physics page ${route.id} not found`)
  const notes: Record<string, Note> = {}
  const pdf_dir = `./${slug}/pdfs/`
  for (const [path, pdf] of Object.entries(assets)) {
    if (!path.startsWith(pdf_dir) || !path.endsWith(`.pdf`)) continue
    const file = path.slice(pdf_dir.length, -`.pdf`.length)
    notes[file] = {
      pdf,
      thumbnail: assets[`./${slug}/thumbnails/${file}.webp`],
      source: sources.has(`${pdf_dir}${file}.typ`)
        ? `${repository}/blob/main/src/routes/physics/${slug}/pdfs/${file}.typ`
        : undefined,
    }
  }
  const description = describe(`physics`, { ...metadata, slug })
  return { frontmatter: { ...metadata, slug, description }, notes }
}
