const queries = require(`./src/utils/algolia`)

require(`dotenv`).config()

module.exports = {
  siteMetadata: {
    title: `janosh.io`,
    description: `Personal blog and portfolio of Janosh Riebesell. Mostly physics, machine learning and web development.`,
    author: `Janosh Riebesell`,
    siteUrl: `https://janosh.io`,
  },
  plugins: [
    `gatsby-transformer-sharp`,
    `gatsby-plugin-sharp`,
    {
      resolve: `gatsby-transformer-remark`,
      options: {
        plugins: [
          `gatsby-remark-smartypants`,
          `gatsby-remark-embed-video`,
          `gatsby-remark-responsive-iframe`,
          `gatsby-remark-katex`,
          `gatsby-remark-copy-linked-files`,
          `gatsby-remark-code-titles`,
          `gatsby-remark-prismjs`,
          {
            resolve: `gatsby-remark-images`,
            options: {
              maxWidth: 1200,
              linkImagesToOriginal: false,
              wrapperStyle: `border-radius: 0.5em; overflow: hidden;`,
            },
          },
          {
            resolve: `gatsby-remark-emojis`,
            options: {
              active: true,
              size: 24,
            },
          },
        ],
      },
    },
    `gatsby-transformer-yaml`,
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        path: `${__dirname}/content`,
      },
    },
    `gatsby-transformer-yaml`,
    `gatsby-plugin-catch-links`,
    `gatsby-plugin-styled-components`,
    {
      resolve: `gatsby-plugin-google-analytics`,
      options: {
        trackingId: process.env.GOOGLE_ANALYTICS_ID,
      },
    },
    {
      resolve: `gatsby-plugin-algolia`,
      options: {
        appId: process.env.GATSBY_ALGOLIA_APP_ID,
        apiKey: process.env.ALGOLIA_ADMIN_KEY,
        queries,
        chunkSize: 10000, // default: 1000
      },
    },
    {
      resolve: `gatsby-plugin-favicon`,
      options: {
        logo: `./content/favicon.png`,
      },
    },
    `gatsby-plugin-react-helmet`,
    `gatsby-plugin-offline`,
    `gatsby-plugin-netlify-cache`,
  ],
}
