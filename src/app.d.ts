declare module '*.md'

namespace App {
  type FrontMatter = import('#lib/types.js').FrontMatter // oxlint-disable-line typescript/consistent-type-imports
  interface PageData {
    // set by the posts layout on /posts/[slug]
    post?: FrontMatter
    // set by the physics layout on /physics/[slug]
    frontmatter?: FrontMatter
  }
}

declare module '*cv.yml' {
  import type * as types from '#lib/types.js'
  const cv: {
    social: types.Social[]
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
