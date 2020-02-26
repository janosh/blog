import React from 'react'
import { Rss } from 'styled-icons/icomoon/Rss'
import styled from 'styled-components'

const Title = styled.span`
  position: absolute;
  top: -0.7em;
  right: -1.7em;
  font-size: 0.7em;
`

const Link = styled.a`
  position: relative;
`

export default () => (
  <Link href="/rss.xml" alt="Subscribe" title="RSS feed">
    <Rss size="1em" />
    <Title>RSS</Title>
  </Link>
)
