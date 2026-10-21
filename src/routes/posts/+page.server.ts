import { describe } from '#lib/server/excerpt.js'
import { posts } from '#lib/server/posts.js'

const tag_groups = Map.groupBy(
  posts.flatMap(({ tags }) => tags),
  (tag) => tag,
)
// Flag tags that differ only in casing since they'd show up as separate filter options.
const lower_tags = new Set([...tag_groups.keys()].map((tag) => tag.toLowerCase()))
if (lower_tags.size < tag_groups.size)
  console.error(`Tags differ only in casing: ${[...tag_groups.keys()].join(`, `)}`)
const top_tags = [...tag_groups]
  .map(([label, tags]) => ({ label, count: tags.length }))
  .toSorted((tag_1, tag_2) => tag_2.count - tag_1.count)
  .slice(0, 15)
  .toSorted((tag_1, tag_2) => tag_1.label.localeCompare(tag_2.label))

export const load = () => ({
  posts: posts.map((post) => ({ ...post, description: describe(`posts`, post) })),
  top_tags,
})
