const queryTemplate = (filters = ``, fields = ``) => `{
  allMdx(filter: {${filters}}) {
    nodes {
      objectID: id
      fileAbsolutePath
      frontmatter {
        title
        slug
        ${fields}
      }
      excerpt(pruneLength: 5000)
    }
  }
}`

const processSlugs = arr =>
  arr.map(({ fileAbsolutePath: fap, ...rest }) =>
    fap.includes(`web/projects`)
      ? { ...rest, slug: `/web?project=${rest.title}` }
      : rest
  )

const flatten = arr =>
  arr.map(({ frontmatter, ...rest }) => ({ ...frontmatter, ...rest }))

const settings = { attributesToSnippet: [`excerpt:20`] }

const queries = [
  {
    query: queryTemplate(`fileAbsolutePath: {regex: "/pages/"}`),
    transformer: res => processSlugs(flatten(res.data.allMdx.nodes)),
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
