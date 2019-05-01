const path = require(`path`)
const fs = require(`fs`)
const ExifReader = require(`exifreader`)

const pageTemplate = path.resolve(`./src/templates/page.js`)
const postTemplate = path.resolve(`./src/templates/post.js`)

const query = `
  {
    pages: allMarkdownRemark(
      filter: { frontmatter: { purpose: { eq: "page" } } }
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
    const nextSlug = index === 0 ? `` : arr[index - 1].node.frontmatter.slug
    const prevSlug =
      index === arr.length - 1 ? `` : arr[index + 1].node.frontmatter.slug
    const slug = node.frontmatter.slug
    if (!slug.startsWith(`/`))
      throw Error(`Post slugs must start with a forward slash!`)
    createPage({
      path: `/blog` + slug,
      component: postTemplate,
      context: { slug, nextSlug, prevSlug },
    })
  })
}

exports.onCreateNode = ({ node, actions }) => {
  if (node.dir && node.dir.includes(`content/photos`) && node.ext === `.jpg`) {
    const buffer = fs.readFileSync(node.absolutePath)
    const tags = ExifReader.load(buffer)
    const meta = {
      lat: tags.GPSLatitude.description,
      lng: tags.GPSLongitude.description,
      caption: tags.Headline.description,
    }
    actions.createNodeField({
      node,
      name: `meta`,
      value: meta,
    })
  }
}
