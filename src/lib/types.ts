// page frontmatter (slug derived from its directory); posts add date and tags
export type PageMeta = {
  title: string
  slug: string
  // meta description; defaults to an excerpt of the page's first paragraph
  description?: string
  cover: {
    img: string
    caption?: string
    // image credit: source name and link
    origin?: string
    url?: string
  }
}

export type PostMeta = PageMeta & { date: string; tags: string[] }

export type Education = {
  title: string
  uni: string
  href: string
  thesis: {
    title: string
    url?: string
    repo?: string
  }
}

export type Experience = {
  organization: string
  href: string
  role?: string
  dates: string
  contributions: string[]
}

export type Reference = {
  title: string
  id: string
  author: { family: string; given: string }[]
  DOI?: string
  URL?: string
  issued: { year: number; month?: number; day?: number }[]
  'container-title'?: string
  note?: string
}

export type Project = {
  name: string
  url?: string
  logo?: string
  color_invert?: `light` | `dark`
  repo: string
  role?: `Lead` | `Maintainer` | `Contributor` | `Former staff member`
  description: string
  // absent for org links (github.com/org#anchor) that have no repo to query
  stars?: number
  commits?: number
  pypi?: string
  languages?: string[]
  paper_key?: string // Zotero BibTeX ID
  paper_url?: string // resolved from paper_key by lib/server/oss.ts
  featured?: boolean
}

export type OssSortKey = `commits` | `stars` | `name`
export type SortOrder = `asc` | `desc`
