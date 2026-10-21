declare module '*.md'

namespace App {
  type PageMeta = import('#lib/types.js').PageMeta // oxlint-disable-line typescript/consistent-type-imports
  type PostMeta = import('#lib/types.js').PostMeta // oxlint-disable-line typescript/consistent-type-imports
  interface PageData {
    // set by the posts and physics layouts on /posts/[slug] and /physics/[slug]
    frontmatter?: PageMeta | PostMeta
    // schema.org Person <script>, set by the home page and CV
    person_json_ld?: string
  }
}

declare module '*cv.yml' {
  import type * as types from '#lib/types.js'
  const cv: {
    experience: types.Experience[]
    selected_projects: types.CvProject[]
    selected_publications: string[]
    education: types.Education[]
    skills: types.SkillGroup[]
    hobbies: types.Hobby[]
    nationality: types.Nationality[]
    languages: types.Language[]
    community: types.Community[]
  }
  export default cv
}

declare module '*oss.yml' {
  import type * as types from '#lib/types.js'
  const oss: {
    projects: types.Project[]
  }
  export default oss
}

declare module '*papers.yaml' {
  import type { Reference } from '#lib/types.js'
  const papers: { references: Reference[] }
  export default papers
}
