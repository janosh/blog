const queries = require('./src/utils/algolia')

require('dotenv').config()

module.exports = {
  siteMetadata: {
    title: `janosh.io`,
    description: `Mostly physics, machine learning, web development, the outdoors... oh and not to forget breaking conventions`,
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
          `gatsby-remark-prismjs`,
          `gatsby-remark-smartypants`,
          `gatsby-remark-embed-video`,
          `gatsby-remark-responsive-iframe`,
          `gatsby-remark-katex`,
          `gatsby-remark-copy-linked-files`,
          {
            resolve: `gatsby-remark-images`,
            options: {
              maxWidth: 1200,
              linkImagesToOriginal: false,
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
    `gatsby-plugin-offline`,
    `gatsby-transformer-yaml`,
    `gatsby-plugin-catch-links`,
    `gatsby-plugin-styled-components`,
    {
      resolve: `gatsby-plugin-google-analytics`,
      options: {
        trackingId: 'UA-122970164-1',
      },
    },
    {
      resolve: `gatsby-plugin-algolia`,
      options: {
        appId: process.env.algoliaAppId,
        apiKey: process.env.algoliaApiKey,
        queries,
        chunkSize: 10000, // default: 1000
      },
    },
    {
      resolve: `gatsby-plugin-favicon`,
      options: {
        logo: './content/favicon.png',
      },
    },
    `gatsby-plugin-react-helmet`,
  ],
}
