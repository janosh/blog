import React from 'react'
import { Caption } from '../styles'
import { Img, PageTitleDiv } from './styles'

export default function PageTitle({ children, img, ...rest }) {
  const { source, caption, url } = img
  return (
    <PageTitleDiv {...rest}>
      <Img {...img} />
      {children}
      {(caption || source) && (
        <Caption showOnHoverParent={PageTitleDiv}>
          <span dangerouslySetInnerHTML={{ __html: caption }} />
          {caption && source && ` | `}
          {source && (
            <span>
              Source: <a href={url}>{source}</a>
            </span>
          )}
        </Caption>
      )}
    </PageTitleDiv>
  )
}
