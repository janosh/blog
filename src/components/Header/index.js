import React from 'react'
import DarkMode from '../DarkMode'
import Nav, { navLinkStyle } from '../Nav'
import Search from '../Search'
import Social from '../Social'
import { HeaderContainer, Logo } from './styles'

const searchIndices = [
  { name: `Pages`, title: `Pages` },
  { name: `Posts`, title: `Blog Posts`, type: `postHit` },
]

const Header = ({ site }) => (
  <HeaderContainer>
    <Logo to="/" title={site.title} rel="home">
      JR
    </Logo>
    <Nav />
    <DarkMode />
    <Social collapse short linkStyle={navLinkStyle} />
    <Search collapse indices={searchIndices} />
  </HeaderContainer>
)

export default Header
