import { graphql } from 'gatsby'

export const query = graphql`
  fragment projects on Query {
    projects: allMdx(
      filter: { fileAbsolutePath: { regex: "/pages/web/projects/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      projects: edges {
        node {
          body
          frontmatter {
            title
            slug
            date(formatString: "MMM D, YYYY")
            url
            repo
            npm
            tech
            ...cover
          }
        }
      }
    }
  }
`
