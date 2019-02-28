import { useStaticQuery, graphql } from "gatsby"

export default () =>
  useStaticQuery(graphql`
    {
      footer: footerYaml {
        copyright
        sourceNote
        poweredBy {
          url
          title
        }
      }
      logos: allFile(
        filter: { dir: { regex: "/footer/logos/" } }
        sort: { fields: name }
      ) {
        edges {
          node {
            src: publicURL
          }
        }
      }
    }
  `)
