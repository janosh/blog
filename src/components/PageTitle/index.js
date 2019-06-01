import React, { useRef, useEffect } from "react"

import { Caption } from "../styles"
import { PageTitleContainer, Title, Img } from "./styles"

export default function PageTitle({ children, img, className, ...rest }) {
  const { backdrop = true, fillToBottom } = rest
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
    <PageTitleContainer {...{ ref, className }}>
      <Img {...img} />
      <Title backdrop={backdrop}>{children}</Title>
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
