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
  thesis_title?: string
  department?: string
  href: string
  logo: string
  description?: string
  date: string
}

export type Reference = {
  title: string
  id: string
  author: { family: string; given: string }[]
  DOI: string
  URL?: string
  issued: { year: number; month: number; day: number }[]
  accessed: { year: number; month: number; day: number }[]
  page: string
  type: string
  ISSN?: string
  arxiv?: string
  icon?: string
}

export type Project = {
  name: string
  url?: string
  logo?: string
  img_style?: string
  repo: string
  role?: 'Lead' | 'Maintainer' | 'Contributor'
  description: string
  stars: number
  commits: number
  pypi?: string
  languages: string[]
  paper?: string // Zotero BibTeX ID
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

export type Membership = {
  name: string
  date: string
  href: string
}

export type Language = {
  name: string
  level: string
  icon: string
}
