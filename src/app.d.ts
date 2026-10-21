declare module '*.md'

namespace App {
  type PageMeta = import('#lib/types.js').PageMeta // oxlint-disable-line typescript/consistent-type-imports
  type PostMeta = import('#lib/types.js').PostMeta // oxlint-disable-line typescript/consistent-type-imports
  interface PageData {
    // set by the posts and physics layouts on /posts/[slug] and /physics/[slug]
    frontmatter?: PageMeta | PostMeta
    // schema.org Person <script>, set by the home page
    person_json_ld?: string
  }
}

declare module '*cv.yml' {
  import type * as types from '#lib/types.js'
  // fields read from TypeScript; cv.typ reads the rest
  const cv: {
    experience: types.Experience[]
    education: types.Education[]
    selected_projects: { name: string }[]
    joint_first_author: string[]
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
