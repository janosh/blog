/// <reference types="@sveltejs/kit" />
/// <reference types="mdsvex/globals" />

declare module '*.md'
declare module '*package.json'

declare module '*cv.yml' {
  import type * as types from '$lib/types'
  const cv: {
    social: types.Social[]
    education: types.Education[]
    skills: types.Skill[]
    hobbies: types.Hobby[]
    nationality: { title: string; icon: string }[]
    languages: types.Language[]
    volunteer: types.Volunteer[]
    awards: types.Award[]
    memberships: types.Membership[]
  }
  export default cv
}

declare module '*oss.yml' {
  import type * as types from '$lib/types'
  const oss: {
    projects: types.Project[]
  }
  export default oss
}

declare module '*papers.yaml' {
  export const references: import('$lib/types').Reference[]
}
