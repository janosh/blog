import { graphql } from 'gatsby'

export const query = graphql`
  fragment sharpSrc on File {
    alt: name
    sharp: childImageSharp {
      fluid(maxWidth: 1500) {
        ...GatsbyImageSharpFluid_withWebp_tracedSVG
      }
    }
    src: publicURL
    dataURI
  }
  fragment cover on MdxFrontmatter {
    cover {
      source
      url
      caption
      img {
        ...sharpSrc
      }
    }
  }
`
