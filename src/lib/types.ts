export type FrontMatter = {
  title: string
  slug: string
  date: string
  cover: {
    img: string
    src: string
    url: string
    caption?: string
    origin?: string
  }
  path: string
  file: string
  tags: string[]
}

export type Education = {
  title: string
  uni: string
  department?: string
  href: string
  logo: string
  description?: string
  date: string
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
  issued: { year: number; month: number; day: number }[]
  accessed: { year: number; month: number; day: number }[]
  page?: string
  type: string
  ISSN?: string
  arxiv?: string
  icon?: string
  'container-title'?: string
  citations?: number
  citation_database?: string
  note?: string
}

export type Project = {
  name: string
  url?: string
  logo?: string
  img_style?: string
  repo: string
  role?: `Lead` | `Maintainer` | `Contributor`
  description: string
  stars: number
  commits: number
  pypi?: string
  languages: string[]
  paper_key?: string // Zotero BibTeX ID
  paper?: Reference
  featured?: boolean
}

export type Skill = {
  name: string
  icon: string
  score: number
  href?: string
  site?: string
}

export type Hobby = {
  name: string
  icon: string
  href: string
}

export type Volunteer = {
  name: string
  description: string
  date: string
  href: string
  logo: string
  role: string
}

export type Award = {
  name: string
  description: string
  date: string
  href: string
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
  icon: string
}

export type Social = {
  name: string
  icon: string
  url: string
  style?: string
}

export const PAPER_SORT_KEYS = {
  date: `date`,
  title: `title`,
  author: `author`,
  first_author: `first author`,
  citations: `citations`,
} as const

export const OSS_SORT_KEYS = {
  commits: `commits`,
  stars: `stars`,
  name: `name`,
} as const
