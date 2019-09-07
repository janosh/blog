import React, { useEffect, useRef } from 'react'
import { useEventListener } from '../../hooks'
import { Caption } from '../styles'
import { Img, PageTitleContainer, Title } from './styles'

export default function PageTitle({ children, img, className, ...rest }) {
  const { backdrop = true, fillToBottom } = rest
  const ref = useRef()
  const fillAvailHeight = () => {
    if (fillToBottom)
      ref.current.style.minHeight =
        window.innerHeight - ref.current.offsetTop + `px`
  }
  useEventListener(`resize`, fillAvailHeight)
  useEffect(fillAvailHeight, [])
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
