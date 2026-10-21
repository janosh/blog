import { strip_html } from 'svelte-widgets/utils'

// Blocks that are not prose: headings, images, HTML, tables, quotes, Svelte blocks, lists,
// display math
const non_prose = /^(?:#|!\[|<|\||>|\{|[-*+] |\d+\. |\$\$)/u

// First prose paragraph of a Markdown page as plain text, cut at a word boundary, for
// the page's meta description and link previews.
export function excerpt(markdown: string, max_len = 160): string {
  const paragraph = markdown
    .replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n/u, ``)
    .replaceAll(/<(?<tag>script|style)\b[\s\S]*?<\/\k<tag>>/gu, ``)
    .replaceAll(/```[\s\S]*?```/gu, ``)
    .replaceAll(/^(?:import|export) .*$/gmu, ``)
    .split(/\n\s*\n/u)
    .map((block) => block.trim())
    .find((block) => block && !non_prose.test(block))
  const text = strip_html(paragraph ?? ``)
    .replaceAll(/\[\^[^\]]+\]/gu, ``)
    .replaceAll(/\[(?<label>[^\]]*)\]\((?:[^()]|\([^)]*\))*\)/gu, `$<label>`)
    .replaceAll(/[*`$]|\b_|_\b/gu, ``)
    .replaceAll(/\s+/gu, ` `)
    .trim()
  if (text.length <= max_len) return text
  const cut = text.lastIndexOf(` `, max_len - 1)
  return `${text.slice(0, cut > 0 ? cut : max_len - 1).replace(/[\s,;:–—-]+$/u, ``)}…`
}

// Excerpts of every post and physics page, keyed by route (e.g. `/posts/hmc-intro`)
const sources = import.meta.glob<string>(`/src/routes/{posts,physics}/*/+page.md`, {
  // Rolldown's production glob parser requires string literals for these options.
  query: '?raw',
  import: 'default',
  eager: true,
})
export const excerpts = Object.fromEntries(
  Object.entries(sources).map(([file, markdown]) => [
    file.slice(`/src/routes`.length, -`/+page.md`.length),
    excerpt(markdown),
  ]),
)

// a page's frontmatter description, else the excerpt of its first paragraph
export const describe = (
  section: `posts` | `physics`,
  { slug, description }: { slug: string; description?: string },
) => description ?? excerpts[`/${section}/${slug}`]
