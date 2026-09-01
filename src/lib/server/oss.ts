import oss from '$lib/oss.yml'
import { assert_ok, create_markdown } from 'svelte-widgets/markdown'

const engine = create_markdown({ typography: true, frontmatter: false })
export const projects = await Promise.all(
  oss.projects.map(async (project) => ({
    ...project,
    description: assert_ok(
      await engine.render(project.description, { filename: `project:${project.repo}` }),
    ),
  })),
)
