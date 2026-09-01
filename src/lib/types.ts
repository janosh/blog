export type FrontMatter = {
  title: string
  slug: string
  date: string
  cover: {
    img: string
    url: string
    caption?: string
    origin?: string
  }
  tags: string[]
}

export type Education = {
  title: string
  uni: string
  department?: string
  href: string
  logo: string
  description?: string
  date?: string
  thesis?: {
    title?: string
    url?: string
    repo?: string
  }
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

export type Publication = Pick<Reference, 'id' | 'title' | 'DOI' | 'URL'> & {
  authors: ({ name: string; is_me: boolean } | null)[]
  first_author: string
  is_first_author: boolean
  issued: Reference['issued'][number]
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
  languages: string[]
  paper_key?: string // Zotero BibTeX ID
  featured?: boolean
}

export type Skill = {
  name: string
  svg?: string
  score: number
  href?: string
  site?: string
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

export type Social = {
  name: string
  url: string
  style?: string
}

export type PaperSortKey = `date` | `title` | `author` | `first author` | `citations`
export type OssSortKey = `commits` | `stars` | `name`
export type SortOrder = `asc` | `desc`
