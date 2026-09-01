export { default as DocsGrid } from './DocsGrid.svelte'
export { default as Footer } from './Footer.svelte'

export * from './oss'
export type * from './types'

// Cover images live next to their +page.md. Bundle them all so posts/physics layouts and
// index pages can resolve `cover.img` from frontmatter to a hashed asset URL.
// Rolldown (vite 8) ignores `import: 'default'` on eager globs and yields module namespaces,
// hence the explicit `.default`
const cover_modules = import.meta.glob<{ default: string }>(
  `/src/routes/{posts,physics}/*/*.{avif,jpg,jpeg,png,svg,webp}`,
  { eager: true },
)

export function cover_url(
  section: `posts` | `physics`,
  slug: string,
  img: string,
): string {
  if (img.startsWith(`http`)) return img
  const src = cover_modules[`/src/routes/${section}/${slug}/${img}`]?.default
  if (!src) throw new Error(`cover ${img} not found in src/routes/${section}/${slug}`)
  return src
}
