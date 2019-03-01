import React, { useRef, useEffect } from "react"

import { PageTitleContainer, Title, Img, Caption } from "./styles"

const PageTitle = ({ children, img, backdrop, className, fillToBottom }) => {
  const ref = useRef()
  if (fillToBottom) {
    const fillAvailHeight = () =>
      (ref.current.style.height =
        window.innerHeight - ref.current.offsetTop + `px`)
    useEffect(() => {
      fillAvailHeight()
      window.addEventListener(`resize`, fillAvailHeight)
      return () => window.removeEventListener(`resize`, fillAvailHeight)
    })
  }
  return (
    <PageTitleContainer ref={ref} className={className}>
      <Img fluid={img && img.fluid} as={(!img || !img.fluid) && `div`} />
      <Title backdrop={backdrop || (img && img.backdrop)}>{children}</Title>
      {(img.caption || img.credit) && (
        <Caption>
          <span dangerouslySetInnerHTML={{ __html: img.caption }} />
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
}

export default PageTitle
