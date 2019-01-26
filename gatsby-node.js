const path = require(`path`)

const pageTemplate = path.resolve(`./src/templates/page.js`)
const postTemplate = path.resolve(`./src/templates/post.js`)

const query = `
  {
    content: allMarkdownRemark {
      edges {
        node {
          path: fileAbsolutePath
          frontmatter {
            slug
            purpose
          }
        }
      }
    }
  }
`

exports.createPages = async ({ graphql, actions: { createPage } }) => {
  const response = await graphql(query)
  if (response.errors) throw new Error(response.errors)
  const { content } = response.data
  content.edges.forEach(({ node: { path, frontmatter } }) => {
    const { slug, purpose } = frontmatter
    if (/content\/pages/.test(path) && purpose === `page`) {
      createPage({
        path: slug,
        component: pageTemplate,
        context: { slug },
      })
    } else if (/content\/posts/.test(path)) {
      createPage({
        path: `blog/` + slug,
        component: postTemplate,
        context: { slug },
      })
    }
  })
}
