const path = require('path')

const pageTemplate = path.resolve('./src/templates/page.js')
const postTemplate = path.resolve('./src/templates/post.js')
const tagTemplate = path.resolve('./src/templates/tag.js')

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
    tags: allMarkdownRemark {
      group(field: frontmatter___tags) {
        title: fieldValue
      }
    }
  }
`

exports.createPages = async ({ graphql, actions: { createPage } }) => {
  const response = await graphql(query)
  if (response.errors) {
    console.error(response.errors)
    throw new Error(response.errors)
  }
  let { content, tags } = response.data
  content.edges.forEach(({ node: { path, frontmatter } }) => {
    const { slug, purpose } = frontmatter
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
  tags = tags.group.map(({ title }) => ({
    title,
    slug: title.toLowerCase().replace(` `, `-`),
  }))
  tags.push({ title: `All`, slug: `` })
  tags.forEach(({ title, slug }) => {
    createPage({
      path: `/blog/` + slug,
      component: tagTemplate,
      context: { title },
    })
  })
}
