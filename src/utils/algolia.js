const pageQuery = `{
  pages: allMarkdownRemark(
    filter: {
      fileAbsolutePath: { regex: "/content/pages/" },
      frontmatter: {purpose: {eq: "page"}}
    }
  ) {
    edges {
      node {
        objectID: id
        frontmatter {
          title
          slug
        }
        excerpt(pruneLength: 5000)
      }
    }
  }
}`

const postQuery = `{
  posts: allMarkdownRemark(
    filter: { fileAbsolutePath: { regex: "/content/posts/" } }
  ) {
    edges {
      node {
        objectID: id
        frontmatter {
          title
          slug
          date(formatString: "MMMM DD, YYYY")
          categories
        }
        excerpt(pruneLength: 5000)
      }
    }
  }
}`

const queries = [
  {
    query: pageQuery,
    transformer: ({ data }) =>
      data.pages.edges.map(({ node: { frontmatter, ...rest } }) => ({
        ...frontmatter,
        ...rest,
      })),
    indexName: `Pages`,
    settings: { attributesToSnippet: [`excerpt:20`] },
  },
  {
    query: postQuery,
    transformer: ({ data }) =>
      data.posts.edges.map(({ node: { frontmatter, ...rest } }) => ({
        ...frontmatter,
        ...rest,
      })),
    indexName: `Posts`,
    settings: { attributesToSnippet: [`excerpt:20`] },
  },
]

module.exports = queries
