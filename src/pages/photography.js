import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import Photos from "../views/Photos"

const PhotographyPage = ({ data, location }) => {
  return (
    <Global path={location.pathname}>
      <Photos {...data.photos} />
    </Global>
  )
}

export default PhotographyPage

export const query = graphql`
  {
    photos: allPhotosYaml {
      photos: edges {
        node {
          title
          img {
            sharp: childImageSharp {
              fluid(quality: 100, maxWidth: 2500) {
                ...GatsbyImageSharpFluid_withWebp
              }
            }
          }
        }
      }
    }
  }
`
