import { graphql } from "gatsby"

export const query = graphql`
  fragment cover on frontmatter_2 {
    cover {
      credit
      url
      caption
      img {
        sharp: childImageSharp {
          fluid(quality: 100, maxWidth: 2000) {
            ...GatsbyImageSharpFluid_withWebp
          }
        }
      }
      backdrop
    }
  }
`
