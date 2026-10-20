import oss from '#lib/oss.yml'
import papers from '#lib/papers.yaml'
import { assert_ok, create_markdown } from 'svelte-widgets/markdown'

const engine = create_markdown({ typography: true, frontmatter: false })
export const projects = await Promise.all(
  oss.projects.map(async (project) => {
    const paper = project.paper_key
      ? papers.references.find(({ id }) => id === project.paper_key)
      : undefined
    if (project.paper_key && !paper) {
      throw new Error(`Paper ${project.paper_key} for ${project.name} not found`)
    }
    return {
      ...project,
      paper_url: paper?.URL,
      description: assert_ok(
        await engine.render(project.description, { filename: `project:${project.repo}` }),
      ),
    }
  }),
)
