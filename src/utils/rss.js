// gatsby-plugin-feed config
// Adapted from https://github.com/gatsbyjs/gatsby/blob/master/packages/gatsby-plugin-mdx/feed.js

module.exports = {
  query: `{
    site {
      siteMetadata {
        title
        url
        site_url: url
        description
      }
    }
  }`,
  setup: ({ query }) => query.site.siteMetadata,
  feeds: [
    {
      serialize: ({ query }) => {
        const { url } = query.site.siteMetadata
        return query.posts.edges.map(({ node }) => {
          const { slug } = node.frontmatter
          return {
            ...node.frontmatter,
            description: node.excerpt,
            url: url + slug,
            guid: url + slug,
            custom_elements: [{ 'content:encoded': node.html }],
          }
        })
      },
      query: `{
        posts: allMdx(
          filter: { fileAbsolutePath: { regex: "/posts/" } }
          sort: { fields: frontmatter___date, order: DESC }
        ) {
          edges {
            node {
              frontmatter {
                title
                slug
                date(formatString: "MMM D, YYYY")
              }
              timeToRead
              excerpt(pruneLength: 300)
              html
            }
          }
        }
      }`,
      output: `/rss.xml`,
    },
  ],
}
