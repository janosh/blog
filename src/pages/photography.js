import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageHeader from "../components/PageHeader"
import Photos from "../views/Photos"

const PhotographyPage = ({ data, location }) => {
  const { photos } = data
  const photo = photos.edges[Math.round(Math.random() * photos.edges.length)]
  return (
    <Global path={location.pathname}>
      <PageHeader img={photo.node.img.sharp}>
        <h1>Photography</h1>
      </PageHeader>
      <Photos photos={photos.edges} />
      <p css="text-align: right; grid-column: 2/-2;">
        These images are for personal enjoyment only. All rights reserved.
      </p>
    </Global>
  )
}

export default PhotographyPage

export const query = graphql`
  {
    photos: allPhotosYaml {
      edges {
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
