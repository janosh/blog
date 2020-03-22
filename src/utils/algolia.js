const queryTemplate = (filters = ``, fields = ``) => `{
  allMdx(filter: {${filters}}) {
    edges {
      node {
        objectID: id
        frontmatter {
          title
          slug
          ${fields}
        }
        excerpt(pruneLength: 5000)
      }
    }
  }
}`

const flatten = arr =>
  arr.map(({ node: { frontmatter, ...rest } }) => ({ ...frontmatter, ...rest }))

const settings = { attributesToSnippet: [`excerpt:20`] }

const queries = [
  {
    query: queryTemplate(`frontmatter: {purpose: {eq: "page"}}`),
    transformer: res => flatten(res.data.allMdx.edges),
    indexName: `Pages`,
    settings,
  },
  {
    query: queryTemplate(
      `fileAbsolutePath: {regex: "/posts/"}`,
      `tags date(formatString: "MMM D, YYYY")`
    ),
    transformer: res => flatten(res.data.allMdx.edges),
    indexName: `Posts`,
    settings,
  },
]

module.exports = queries
