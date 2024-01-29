import yaml from '@rollup/plugin-yaml'
import { sveltekit } from '@sveltejs/kit/vite'
import fs from 'fs'
import yamljs from 'js-yaml'
import { loadEnv, type UserConfig } from 'vite'

async function fetch_github_data(gh_token: string) {
  const auth = { headers: { Authorization: `token ${gh_token}` } }
  const cv = yamljs.load(fs.readFileSync(`src/lib/oss.yml`, `utf8`))

  for (const project of cv.projects) {
    const handle = project.repo.replace(`https://github.com/`, ``)

    const repo = await (
      await fetch(`https://api.github.com/repos/${handle}`, auth)
    ).json()

    project.stars = repo.stargazers_count
    // fetch number of commits by contributor.login using repo contribs API
    const contributors = await (
      await fetch(`https://api.github.com/repos/${handle}/contributors`, auth)
    ).json()
    const me = contributors.find(
      (contributor: Record<string, unknown>) => contributor.login === `janosh`,
    )
    if (me) {
      project.commits = me.contributions
    }

    const languages = await (
      await fetch(`https://api.github.com/repos/${handle}/languages`, auth)
    ).json()
    project.languages = Object.keys(languages)
  }

  fs.writeFileSync(`src/lib/oss.yml`, yamljs.dump(cv, { lineWidth: -1 }))
}

process.env = { ...process.env, ...loadEnv(``, process.cwd(), ``) }
const { gh_token } = process.env

if (gh_token) {
  fetch_github_data(gh_token)
} else {
  console.error(`No GitHub token found, skipping GitHub API calls`)
}

export default {
  plugins: [sveltekit(), yaml()],

  server: {
    port: 3000,
    fs: {
      allow: [`..`],
    },
  },

  preview: {
    port: 3000,
  },

  ssr: {
    noExternal: [`three`],
  },
} satisfies UserConfig
