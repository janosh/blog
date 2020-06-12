const path = require(`path`)
const fs = require(`fs`)
const ExifReader = require(`exifreader`)

const pageTemplate = path.resolve(`./src/templates/page.js`)
const postTemplate = path.resolve(`./src/templates/post.js`)

const query = `
  {
    pages: allMdx(
      filter: { frontmatter: { purpose: { eq: "page" } } }
    ) {
      nodes {
        frontmatter {
          slug
        }
      }
    }
    posts: allMdx(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      nodes {
        frontmatter {
          slug
        }
      }
    }
  }
`

exports.createPages = async ({ graphql, actions }) => {
  const response = await graphql(query)
  if (response.errors) throw new Error(response.errors)
  const { pages, posts } = response.data

  pages.nodes.forEach(page => {
    const { slug } = page.frontmatter
    actions.createPage({
      path: slug,
      component: pageTemplate,
      context: { slug },
    })
  })

  posts.nodes.forEach((post, index, arr) => {
    const nextSlug = arr[index - 1]?.frontmatter.slug || ``
    const prevSlug = arr[index + 1]?.frontmatter.slug || ``
    const { slug } = post.frontmatter
    actions.createPage({
      path: slug,
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
    actions.createNodeField({ node, name: `meta`, value: meta })
  }
  if (
    node.internal.type === `Mdx` &&
    node.fileAbsolutePath.includes(`content/posts`)
  ) {
    node.frontmatter.slug = `/blog` + node.frontmatter.slug
  }
}

// Enable absolute imports from `src`.
// See https://gatsbyjs.org/docs/add-custom-webpack-config#absolute-imports.
exports.onCreateWebpackConfig = ({ actions }) => {
  actions.setWebpackConfig({
    resolve: {
      modules: [path.resolve(__dirname, `src`), `node_modules`],
    },
  })
}
