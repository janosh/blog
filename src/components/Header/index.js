import React from 'react'

import { Container, Logo } from './styles'
import Nav from '../Nav'
import Social from '../Social'
import Search from '../Search'
import { navLinkStyle } from '../Nav/styles'

const searchIndices = [
  { name: `Pages`, title: `Pages`, hitComp: `PageHit` },
  { name: `Posts`, title: `Blog Posts`, hitComp: `PostHit` },
]

const Header = ({ site, transparent }) => (
  <Container transparent={transparent}>
    <Logo to="/" title={site.title} rel="home">
      JR
    </Logo>
    <Nav />
    <Social collapse short css={navLinkStyle} />
    <Search collapse indices={searchIndices} />
  </Container>
)

export default Header
