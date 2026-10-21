import oss from '#lib/oss.yml'
import papers from '#lib/papers.yaml'
import { assert_ok, create_markdown } from 'svelte-widgets/markdown'

const engine = create_markdown({ typography: true, frontmatter: false })
// card and list descriptions are inline markdown (links, emphasis), rendered to HTML
export const render_description = async (markdown: string, filename: string) =>
  assert_ok(await engine.render(markdown, { filename }))

export const projects = await Promise.all(
  oss.projects.map(async (project) => {
    const paper = papers.references.find(({ id }) => id === project.paper_key)
    if (project.paper_key && !paper) {
      throw new Error(`Paper ${project.paper_key} for ${project.name} not found`)
    }
    return {
      ...project,
      paper_url: paper?.URL,
      description: await render_description(
        project.description,
        `project:${project.repo}`,
      ),
    }
  }),
)
