import React from 'react'

import { Container, Logo } from './styles'
import Nav from '../Nav'
import Social from '../Social'
import Search from '../Search'
import { navLinkStyle } from '../Nav/styles'

const Header = ({ site, transparent }) => (
  <Container transparent={transparent}>
    <Logo to="/" title={site.title} rel="home">
      JR
    </Logo>
    <Nav />
    <Social short collapse css={navLinkStyle} />
    <Search />
  </Container>
)

export default Header
