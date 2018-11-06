const path = require('path')

const pageTemplate = path.resolve('./src/templates/page.js')
const postTemplate = path.resolve('./src/templates/post.js')
const categoryTemplate = path.resolve('./src/templates/blogCategory.js')

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
    categories: allMarkdownRemark {
      group(field: frontmatter___categories) {
        title: fieldValue
      }
    }
  }
`

exports.createPages = async ({ graphql, actions }) => {
  const { createPage } = actions
  const response = await graphql(query)
  if (response.errors) {
    console.error(response.errors)
    throw new Error(response.errors)
  }
  const { content, categories } = response.data
  content.edges.forEach(({ node }) => {
    const {
      path,
      frontmatter: { slug, purpose },
    } = node
    if (/content\/pages/.test(path) && purpose === `page`) {
      createPage({
        path: slug,
        component: pageTemplate,
        context: { slug },
      })
    }
    if (/content\/posts/.test(path)) {
      createPage({
        path: `/blog/` + slug,
        component: postTemplate,
        context: { slug },
      })
    }
  })
  categories.group.forEach(category => {
    const { title } = category
    createPage({
      path: `/blog/` + title.toLowerCase().replace(` `, `-`),
      component: categoryTemplate,
      context: { title },
    })
  })
}
