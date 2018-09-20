import React from 'react'
import { graphql } from 'gatsby'
import Img from 'gatsby-image'

import Global from '../components/Global'
import Slideshow from '../components/Slideshow'
import LandingTitle from '../components/LandingTitle'
import About from '../components/About'

const LandingPage = ({ data, location }) => {
  const { photos } = data
  return (
    <Global transparent path={location.pathname}>
      <Slideshow>
        {photos.edges.map(({ node }) => (
          <Img key={node.name} fluid={node.img.fluid} alt={node.name} />
        ))}
      </Slideshow>
      <LandingTitle>
        <h1>Hi there!</h1>
        <h2>Welcome to my site. My name is Janosh.</h2>
        <About />
      </LandingTitle>
    </Global>
  )
}

export default LandingPage

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
  }
`
