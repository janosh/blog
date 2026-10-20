import type { OssSortKey, Project, Reference, SortOrder } from './types.js'
import type { Attachment } from 'svelte/attachments'

export { default as Cover } from './Cover.svelte'
export { default as Footer } from './Footer.svelte'
export type * from './types.js'

// A partial date sorts at the start of its known year or month.
export const date_num = ({ year, month = 0, day = 0 }: Reference[`issued`][number]) =>
  year * 10000 + month * 100 + day

const month_year = new Intl.DateTimeFormat(`en-GB`, {
  month: `short`,
  year: `numeric`,
  timeZone: `UTC`,
})

export const format_issued = ({ year, month }: Reference[`issued`][number]) =>
  month === undefined
    ? String(year)
    : month_year.format(new Date(Date.UTC(year, month - 1)))

// Run once near the viewport, and release the observer on activation or unmount.
export const when_visible =
  (activate: () => void): Attachment =>
  (node) => {
    const observer = new IntersectionObserver(
      (entries) => {
        if (!entries.some(({ isIntersecting }) => isIntersecting)) return
        observer.disconnect()
        activate()
      },
      { rootMargin: `200px` },
    )
    observer.observe(node)
    return () => observer.disconnect()
  }

// Cover images live next to their +page.md. Bundle them all so posts/physics layouts and
// index pages can resolve `cover.img` from frontmatter to a hashed asset URL.
const cover_modules = import.meta.glob<string>(
  `/src/routes/{posts,physics}/*/*.{avif,jpg,jpeg,png,svg,webp}`,
  // Rolldown's production glob parser requires string literals for these options.
  { import: 'default', eager: true },
)

// logos in src/lib, referenced by file name from oss.yml and cv.yml
const lib_svgs = import.meta.glob<string>(`./*.svg`, { import: 'default', eager: true })
export const asset_url = (src: string) => lib_svgs[`./${src}`] ?? src

export function cover_url(
  section: `posts` | `physics`,
  slug: string,
  img: string,
): string {
  if (img.startsWith(`http`)) return img
  const src = cover_modules[`/src/routes/${section}/${slug}/${img}`]
  if (!src) throw new Error(`cover ${img} not found in src/routes/${section}/${slug}`)
  return src
}

// Every prerendered page route, derived from +page files (route groups in parens stripped).
// Shared by the command palette, the sitemap and the RSS feed.
export const site_routes = Object.keys(
  import.meta.glob(`/src/routes/**/+page*.{md,svelte}`),
).map((file) => {
  const parts = file.split(`/`).filter((part) => !part.startsWith(`(`))
  return `/${parts.slice(3, -1).join(`/`)}`
})

// Match a project's name, description text (not markup or URLs) and languages.
export const project_matches = (
  {
    name,
    description,
    languages = [],
  }: Pick<Project, `name` | `description` | `languages`>,
  query: string,
) =>
  [name, description.replaceAll(/<[^>]*>/gu, ` `), ...languages]
    .join(` `)
    .toLowerCase()
    .includes(query.toLowerCase())

export const oss_sort_keys = [
  { value: `commits`, tooltip: `Sort by commits` },
  { value: `stars`, tooltip: `Sort by stars` },
  { value: `name`, tooltip: `Sort by name` },
] as const

export function sort_oss_projects<
  ProjectT extends Pick<Project, `name` | `commits` | `stars`>,
>(
  projects: readonly ProjectT[],
  sort_by: OssSortKey,
  sort_order: SortOrder = `desc`,
): ProjectT[] {
  const sort_direction = sort_order === `asc` ? 1 : -1

  return projects.toSorted((project_1, project_2) => {
    if (sort_by === `name`)
      return project_1.name.localeCompare(project_2.name) * sort_direction
    return ((project_1[sort_by] ?? 0) - (project_2[sort_by] ?? 0)) * sort_direction
  })
}
