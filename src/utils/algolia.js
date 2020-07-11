const queryTemplate = (filters = ``, fields = ``) => `{
  allMdx(filter: {${filters}}) {
    nodes {
      objectID: id
      frontmatter {
        title
        slug
        ${fields}
      }
      excerpt(pruneLength: 5000)
    }
  }
}`

const flatten = arr =>
  arr.map(({ frontmatter, ...rest }) => ({ ...frontmatter, ...rest }))

const settings = { attributesToSnippet: [`excerpt:20`] }

const queries = [
  {
    query: queryTemplate(`fileAbsolutePath: {regex: "/pages/"}`),
    transformer: res => flatten(res.data.allMdx.nodes),
    indexName: `Pages`,
    settings,
  },
  {
    query: queryTemplate(
      `fileAbsolutePath: {regex: "/posts/"}`,
      `tags date(formatString: "MMM D, YYYY")`
    ),
    transformer: res => flatten(res.data.allMdx.nodes),
    indexName: `Posts`,
    settings,
  },
]

module.exports = queries
