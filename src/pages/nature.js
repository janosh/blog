import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import Photos from "../views/Photos"

const NaturePage = ({ data, location }) => {
  const { photos } = data
  const photo = photos.edges[Math.floor(Math.random() * photos.edges.length)]
  return (
    <Global path={location.pathname}>
      <PageTitle img={photo.node.img.sharp}>
        <h1>Nature</h1>
      </PageTitle>
      <PageBody cols="2/-2">
        <Photos photos={photos.edges} />
      </PageBody>
    </Global>
  )
}

export default NaturePage

export const query = graphql`
  {
    photos: allPhotosYaml {
      edges {
        node {
          title
          img {
            sharp: childImageSharp {
              fluid(maxWidth: 1800) {
                ...GatsbyImageSharpFluid_withWebp
              }
            }
          }
        }
      }
    }
  }
`
