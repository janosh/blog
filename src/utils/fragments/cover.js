import { graphql } from "gatsby"

export const query = graphql`
  fragment sharpSrc on File {
    sharp: childImageSharp {
      fluid(maxWidth: 1800) {
        ...GatsbyImageSharpFluid_withWebp
      }
    }
    src: publicURL
  }
  fragment cover on MarkdownRemarkFrontmatter {
    cover {
      credit
      url
      caption
      img {
        ...sharpSrc
      }
      thumbnail {
        ...sharpSrc
      }
      backdrop
    }
  }
`
