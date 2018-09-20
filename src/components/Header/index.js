import React from 'react'

import { Container, Logo, SiteTitle } from './styles'
import Nav from '../Nav'
import Social from '../Social'
import { navLinkStyle } from '../Nav/styles'

const Header = ({ site, transparent }) => (
  <Container transparent={transparent}>
    <SiteTitle to="/" title={site.title} rel="home" styles={navLinkStyle}>
      <Logo />
    </SiteTitle>
    <Nav />
    <Social expandOnHover iconCss={navLinkStyle} />
  </Container>
)

export default Header
