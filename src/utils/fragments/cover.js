import { graphql } from "gatsby"

export const query = graphql`
  fragment cover on frontmatter_2 {
    cover {
      credit
      url
      caption
      img {
        sharp: childImageSharp {
          fluid(maxWidth: 1800) {
            ...GatsbyImageSharpFluid_withWebp
          }
        }
        src: publicURL
      }
      backdrop
    }
  }
`
