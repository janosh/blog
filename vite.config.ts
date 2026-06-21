import { config } from '@janosh/vite-config'
import rollup_yaml from '@rollup/plugin-yaml'
import { sveltekit } from '@sveltejs/kit/vite'
import { dump, load } from 'js-yaml'
import { execSync } from 'node:child_process'
import fs from 'node:fs'
import { defineConfig } from 'vite-plus'

const is_record = (value: unknown): value is Record<string, unknown> =>
  typeof value === `object` && value !== null

async function fetch_github_data(gh_token: string) {
  const auth = { headers: { Authorization: `token ${gh_token}` } }
  const oss_data = load(fs.readFileSync(`src/lib/oss.yml`, `utf8`))
  if (!is_record(oss_data) || !Array.isArray(oss_data.projects)) {
    throw new TypeError(`Invalid oss.yml structure`)
  }
  const projects = oss_data.projects
  if (
    !projects.every(
      (project): project is { repo: string; stars?: number; commits?: number } =>
        is_record(project) && typeof project.repo === `string`,
    )
  ) {
    throw new TypeError(`Invalid oss.yml projects`)
  }

  // allSettled so one repo's failure doesn't discard updates for all the others
  const results = await Promise.allSettled(
    projects.map(async (project) => {
      const handle = project.repo.replace(`https://github.com/`, ``)

      const repo_resp = await fetch(`https://api.github.com/repos/${handle}`, auth)
      if (!repo_resp.ok) {
        console.error(`GitHub API ${repo_resp.status} for ${handle}, skipping`)
        return
      }
      const repo: unknown = await repo_resp.json()
      if (!is_record(repo) || typeof repo.stargazers_count !== `number`) {
        throw new Error(`Invalid repo response for ${handle}`)
      }
      project.stars = repo.stargazers_count

      const contribs_url = `https://api.github.com/repos/${handle}/contributors`
      const contribs_resp = await fetch(contribs_url, auth)
      if (!contribs_resp.ok) return
      const contributors: unknown = await contribs_resp.json()
      if (!Array.isArray(contributors)) {
        throw new TypeError(`Invalid contributors response for ${handle}`)
      }
      const me = contributors.find(
        (contributor) => is_record(contributor) && contributor.login === `janosh`,
      )
      if (is_record(me) && typeof me.contributions === `number`) {
        project.commits = me.contributions
      }
    }),
  )
  for (const result of results) {
    if (result.status === `rejected`) {
      console.error(`GitHub API update failed: ${result.reason}`)
    }
  }

  fs.writeFileSync(`src/lib/oss.yml`, dump(oss_data, { lineWidth: -1 }))
}

try {
  const gh_token = execSync(`gh auth token`, { encoding: `utf8` }).trim()
  void fetch_github_data(gh_token).catch((error: unknown) => {
    console.error(`GitHub API update failed, skipping: ${String(error)}`)
  })
} catch {
  console.error(`No GitHub token found, skipping GitHub API calls`)
}

export default defineConfig({
  ...config, // shared lint/fmt/build from @janosh/vite-config (dotfiles)
  plugins: [sveltekit(), rollup_yaml()],

  server: {
    port: 3000,
    fs: {
      allow: [`..`],
    },
  },

  preview: {
    port: 3000,
  },
})
