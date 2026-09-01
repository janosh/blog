/// <reference types="node" />

import { execFileSync } from 'node:child_process'
import fs from 'node:fs'
import { dump, load } from 'js-yaml'

const is_record = (value: unknown): value is Record<string, unknown> =>
  typeof value === `object` && value !== null

type GhProject = { repo: string; stars?: number; commits?: number }

async function update_project(project: GhProject, gh_token: string): Promise<void> {
  const handle = project.repo.replace(`https://github.com/`, ``)
  // Organization links have no repository statistics.
  if (!/^[\w.-]+\/[\w.-]+$/.test(handle)) return

  async function get_json(url: string): Promise<unknown> {
    try {
      const response = await fetch(url, {
        headers: { Authorization: `Bearer ${gh_token}` },
        signal: AbortSignal.timeout(10_000),
      })
      if (!response.ok) throw new Error(`GitHub API ${response.status}`)
      // The contributors endpoint returns 204 for an empty repository.
      return response.status === 204 ? [] : await response.json()
    } catch (cause) {
      throw new Error(`GitHub request failed for ${url}: ${String(cause)}`, { cause })
    }
  }

  const repo_url = `https://api.github.com/repos/${handle}`
  const repo = await get_json(repo_url)
  if (!is_record(repo) || typeof repo.stargazers_count !== `number`) {
    throw new TypeError(`Invalid repository response for ${repo_url}`)
  }
  let commits = 0
  for (let page = 1; ; page++) {
    const url = `${repo_url}/contributors?per_page=100&page=${page}`
    const contributors = await get_json(url)
    if (!Array.isArray(contributors)) {
      throw new TypeError(`Invalid contributors response for ${url}`)
    }
    const me: unknown = contributors.find(
      (contributor: unknown) => is_record(contributor) && contributor.login === `janosh`,
    )
    if (is_record(me)) {
      if (typeof me.contributions !== `number`) {
        throw new TypeError(`Invalid contribution count for janosh at ${url}`)
      }
      commits = me.contributions
      break
    }
    if (contributors.length < 100) break
  }
  // Commit both counts only after all requests for this repository succeed.
  Object.assign(project, { stars: repo.stargazers_count, commits })
}

export async function update_oss(gh_token: string): Promise<void> {
  const filename = new URL(`../src/lib/oss.yml`, import.meta.url)
  const source = fs.readFileSync(filename, `utf8`)
  const oss_data: unknown = load(source)
  if (!is_record(oss_data) || !Array.isArray(oss_data.projects)) {
    throw new TypeError(`Invalid oss.yml structure`)
  }
  const is_project = (project: unknown): project is GhProject =>
    is_record(project) && typeof project.repo === `string`
  if (!oss_data.projects.every(is_project)) {
    throw new TypeError(`Invalid oss.yml projects`)
  }

  // Leave the file untouched if any repository fails or it changed during the refresh.
  await Promise.all(oss_data.projects.map((project) => update_project(project, gh_token)))
  if (fs.readFileSync(filename, `utf8`) !== source) {
    throw new Error(`oss.yml changed during the GitHub refresh; refusing to overwrite it`)
  }
  fs.writeFileSync(filename, dump(oss_data, { lineWidth: -1 }))
}

if (import.meta.main) {
  const gh_token = execFileSync(`gh`, [`auth`, `token`], { encoding: `utf8` }).trim()
  await update_oss(gh_token)
}
