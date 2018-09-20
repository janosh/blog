import React from 'react'
import styled from 'styled-components'
import { Rss } from 'styled-icons/icomoon'

const Title = styled.span`
  position: absolute;
  top: -0.7em;
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
