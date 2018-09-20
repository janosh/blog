// gatsby-plugin-sitemap config
// https://github.com/gatsbyjs/gatsby/tree/master/packages/gatsby-plugin-sitemap#options

module.exports = {
  output: `/sitemap.xml`,
  query: `{
    site {
      meta: siteMetadata {
        url
      }
    }
    pages: allSitePage {
      nodes {
        path
      }
    }
  }`,
  resolveSiteUrl: ({ site }) => site.meta.url,
  serialize: ({ site, pages }) =>
    pages.nodes.map(node => ({ url: site.meta.url + node.path })),
}
