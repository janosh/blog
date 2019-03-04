import React, { useRef, useEffect } from "react"

import Caption from "../styles/Caption"
import { PageTitleContainer, Title, Img } from "./styles"

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
      <Img {...img} />
      <Title backdrop={backdrop || (img && img.backdrop)}>{children}</Title>
      {img && (img.caption || img.credit) && (
        <Caption showOnHoverParent={PageTitleContainer}>
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
