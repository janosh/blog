import React from 'react'
import { graphql } from 'gatsby'
import Img from 'gatsby-image'

import Global from '../components/Global'
import Slideshow from '../components/Slideshow'
import LandingTitle from '../components/LandingTitle'

const IndexPage = ({ data: { photos, me }, location }) => (
  <Global margin="0" transparent path={location.pathname}>
    <Slideshow>
      {photos.edges.map(({ node }) => (
        <Img key={node.name} fluid={node.img.fluid} alt={node.name} />
      ))}
    </Slideshow>
    <LandingTitle me={me} />
  </Global>
)

export default IndexPage

export const query = graphql`
  {
    photos: allFile(
      filter: { relativeDirectory: { eq: "pages/index/photos" } }
    ) {
      edges {
        node {
          name
          img: childImageSharp {
            fluid(quality: 100, maxWidth: 2500) {
              ...GatsbyImageSharpFluid_withWebp
            }
          }
        }
      }
    }
    me: file(name: { eq: "me" }) {
      img: childImageSharp {
        fluid(maxWidth: 500) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
