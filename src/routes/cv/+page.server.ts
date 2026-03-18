import oss from '$lib/oss.yml'
import { compile } from 'mdsvex'

export async function load() {
  const projects = await Promise.all(
    oss.projects.map(async (project) => {
      const { code } = (await compile(project.description)) ?? {}
      if (code === undefined || code.length === 0) {
        throw new Error(`Failed to compile description for ${project.name}`)
      }
      return { ...project, description: code }
    }),
  )
  return { oss: { ...oss, projects } }
}
