const path = require(`path`)
const fs = require(`fs`)
const fastExif = require(`fast-exif`)
const iptc = require(`node-iptc`)

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

const latLngReducer = (acc, val, index) => acc + val / Math.pow(60, index)

exports.onCreateNode = async ({ node, actions }) => {
  if (node.dir && node.dir.includes(`content/photos`) && node.ext === `.jpg`) {
    await fs.readFile(node.absolutePath, (err, img) => {
      if (err) throw err
      actions.createNodeField({
        node,
        name: `iptc`,
        value: iptc(img),
      })
    })
    fastExif
      .read(node.absolutePath)
      .then(exifData => {
        if (exifData && exifData.gps) {
          const lat = exifData.gps.GPSLatitude.reduce(latLngReducer, 0)
          const lng = exifData.gps.GPSLongitude.reduce(latLngReducer, 0)
          actions.createNodeField({
            node,
            name: `gps`,
            value: { lat, lng },
          })
        }
      })
      // eslint-disable-next-line no-console
      .catch(console.error)
  }
}
