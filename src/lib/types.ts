export type FrontMatter = {
  title: string
  slug: string
  date: string
  cover: {
    img: string
    src: string
    url: string
  }
  path: string
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

export type Publication = {
  name: string
  title: string
  authors: string
  date: string
  journal: string
  url?: string
  arxiv?: string
  icon?: string
}

export type Project = {
  name: string
  url?: string
  logo?: string
  img_style?: string
  github: string
  description: string
  stars: number
  pypi?: string
  languages: string[]
}

export type Skill = {
  name: string
  icon: string
  score: number
  href?: string
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
}
