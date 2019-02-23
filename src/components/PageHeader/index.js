import React from "react"

import { Container, Title, Img, Caption } from "./styles"

const PageHeader = ({ children, img, backdrop }) => (
  <Container>
    <Img fluid={img && img.fluid} as={(!img || !img.fluid) && `div`} />
    <Title backdrop={backdrop || (img && img.backdrop)}>{children}</Title>
    {(img.caption || img.credit) && (
      <Caption>
        {img.caption}
        {img.caption && img.credit && ` | `}
        {img.credit && (
          <span>
            Credit: <a href={img.url}>{img.credit}</a>
          </span>
        )}
      </Caption>
    )}
  </Container>
)

export default PageHeader
