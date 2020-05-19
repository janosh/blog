import React, { useState } from 'react'
import { graphql } from 'gatsby'

import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import { PageBody, ButtonGroup } from 'components/styles'
import Photos from 'views/Photos'

export default function NaturePage({ data, location }) {
  const [modal, setModal] = useState()
  const [tab, setTab] = useState(`list`)
  const photos = data.photos.edges.map(({ node }) => ({
    ...(node.fields && node.fields.meta),
    ...node.img,
  }))
  const photoProps = { tab, modal, setModal, photos }
  const buttonProps = tabName => ({
    className: tab === tabName ? `active` : null,
    onClick: () => setTab(tabName),
  })
  return (
    <Global path={location.pathname}>
      <PageTitle img={photos[13].fluid}>
        <h1>Nature</h1>
      </PageTitle>
      <PageBody cols="2/-2">
        <ButtonGroup css="margin-top: 0;">
          <button {...buttonProps(`list`)}>List</button>
          <button {...buttonProps(`map`)}>Map</button>
        </ButtonGroup>
        <Photos {...photoProps} />
      </PageBody>
    </Global>
  )
}

export const query = graphql`
  {
    photos: allFile(
      filter: { dir: { regex: "/content/photos/" }, ext: { eq: ".jpg" } }
    ) {
      edges {
        node {
          fields {
            meta {
              caption
              lat
              lng
            }
          }
          img: childImageSharp {
            fluid(maxWidth: 2000) {
              ...GatsbyImageSharpFluid_withWebp
            }
          }
        }
      }
    }
  }
`
