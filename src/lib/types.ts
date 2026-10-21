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
  department?: string
  href: string
  logo: string
  description?: string
  thesis: {
    title: string
    url?: string
    repo?: string
  }
}

export type Experience = {
  organization: string
  href: string
  logo: string
  color_invert?: Project[`color_invert`]
  role?: string
  dates: string
  contributions: string[]
}

export type CvProject = {
  name: string
  role: NonNullable<Project[`role`]>
  contribution: string
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

export type Publication = Pick<Reference, `id` | `title` | `DOI` | `URL`> & {
  authors: ({ name: string; is_me: boolean } | null)[]
  issued: Reference[`issued`][number]
  journal?: string
  citations: number
  citation_database: string
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

export type Skill = {
  name: string
  logo?: string // file in src/lib, used instead of a svelte-widgets glyph
  href?: string
  site?: string
}

export type SkillGroup = {
  name: string
  items: Skill[]
}

export type Hobby = {
  name: string
  href?: string
}

export type Community = {
  name: string
  role?: string
  date: string
  href: string
  img: string
}

export type Language = {
  name: string
  level: string
  flag: string
}

export type Nationality = {
  title: string
  flag: string
}

export type OssSortKey = `commits` | `stars` | `name`
export type SortOrder = `asc` | `desc`
