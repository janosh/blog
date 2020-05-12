import PageTitle from 'components/PageTitle'
import { ButtonGroup, PageBody } from 'components/styles'
import { graphql } from 'gatsby'
import React, { useState } from 'react'
import Photos from 'views/Photos'

export default function NaturePage({ data }) {
  const [modal, setModal] = useState()
  const [tab, setTab] = useState(`list`)
  const photos = data.photos.edges.map(({ node }) => ({
    ...node?.fields.meta,
    ...node.sharp,
  }))
  const buttonProps = tabName => ({
    className: tab === tabName ? `active` : null,
    onClick: () => setTab(tabName),
  })
  const { cover } = data.mdx.frontmatter
  return (
    <>
      <PageTitle img={{ ...cover, ...cover.img }}>
        <h1>Nature</h1>
      </PageTitle>
      <PageBody cols="2/-2">
        <ButtonGroup css="margin-top: 0;">
          <button {...buttonProps(`list`)}>List</button>
          <button {...buttonProps(`map`)}>Map</button>
        </ButtonGroup>
        <Photos {...{ tab, modal, setModal, photos }} />
      </PageBody>
    </>
  )
}

export const query = graphql`
  {
    photos: allFile(
      filter: { dir: { regex: "/content/photos/" }, ext: { eq: ".jpg" } }
    ) {
      edges {
        node {
          ...sharpSrc
          fields {
            meta {
              caption
              lat
              lng
            }
          }
        }
      }
    }
    mdx(fileAbsolutePath: { regex: "/nature.md/" }) {
      frontmatter {
        ...cover
      }
    }
  }
`
