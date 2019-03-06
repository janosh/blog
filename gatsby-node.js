const path = require(`path`)

const pageTemplate = path.resolve(`./src/templates/page.js`)
const postTemplate = path.resolve(`./src/templates/post.js`)

const query = `
  {
    pages: allMarkdownRemark(
      filter: {frontmatter: {purpose: {eq: "page"}}}
    ) {
      edges {
        node {
          frontmatter {
            slug
          }
        }
      }
    }
    posts: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      edges {
        node {
          frontmatter {
            title
            slug
          }
        }
      }
    }
  }
`

exports.createPages = async ({ graphql, actions: { createPage } }) => {
  const response = await graphql(query)
  if (response.errors) throw new Error(response.errors)
  const { pages, posts } = response.data
  pages.edges.forEach(({ node }) => {
    const { slug } = node.frontmatter
    createPage({
      path: slug,
      component: pageTemplate,
      context: { slug },
    })
  })
  posts.edges.forEach(({ node }, index, arr) => {
    const previous = index === arr.length - 1 ? null : arr[index + 1].node
    const next = index === 0 ? null : arr[index - 1].node
    const slug = node.frontmatter.slug
    if (!slug.startsWith(`/`)) throw Error(`Post slugs must start with a forward slash!`)
    createPage({
      path: `/blog` + slug,
      component: postTemplate,
      context: { slug, previous, next },
    })
  })
}
