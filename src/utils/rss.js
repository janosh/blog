// gatsby-plugin-feed config
// Adapted from https://github.com/gatsbyjs/gatsby/blob/master/packages/gatsby-plugin-mdx/feed.js

module.exports = {
  query: `{
    site {
      meta: siteMetadata {
        title
        url
        site_url: url
        description
      }
    }
  }`,
  setup: ({ query }) => query.site.meta,
  feeds: [
    {
      serialize: ({ query }) => {
        const { url } = query.site.meta
        return query.posts.nodes.map(post => {
          const { slug } = post.frontmatter
          return {
            ...post.frontmatter,
            description: post.excerpt,
            url: url + slug,
            guid: url + slug,
            custom_elements: [{ 'content:encoded': post.html }],
          }
        })
      },
      query: `{
        posts: allMdx(
          filter: { fileAbsolutePath: { regex: "/posts/" } }
          sort: { fields: frontmatter___date, order: DESC }
        ) {
          nodes {
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
      }`,
      output: `/rss.xml`,
    },
  ],
}
