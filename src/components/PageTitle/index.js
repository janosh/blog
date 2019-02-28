import React from "react"

import { PageTitleContainer, Title, Img, Caption } from "./styles"

const PageTitle = ({ children, img, backdrop }) => (
  <PageTitleContainer>
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
  </PageTitleContainer>
)

export default PageTitle
