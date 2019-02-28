import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import Photos from "../views/Photos"

const PhotographyPage = ({ data, location }) => {
  const { photos } = data
  const photo = photos.edges[Math.round(Math.random() * photos.edges.length)]
  return (
    <Global path={location.pathname}>
      <PageTitle img={photo.node.img.sharp}>
        <h1>Photography</h1>
      </PageTitle>
      <PageBody cols="2/-2">
        <Photos photos={photos.edges} />
        <p css="text-align: right;">
          These images are for personal enjoyment only. All rights reserved.
        </p>
      </PageBody>
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
