import oss from '$lib/oss.yml'
import { compile } from 'mdsvex'

export async function load() {
  for (const project of oss.projects) {
    // deno-lint-ignore no-await-in-loop
    const { code } = await compile(project.description) ?? {}
    if (!code) throw new Error(`Failed to compile description for ${project.name}`)
    project.description = code
  }
  return { oss }
}
