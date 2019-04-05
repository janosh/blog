import React from "react"

import { HeaderContainer, Logo } from "./styles"
import Nav from "../Nav"
import Social from "../Social"
import Search from "../Search"
import { navLinkStyle } from "../Nav"

const searchIndices = [
  { name: `Pages`, title: `Pages`, hitComp: `PageHit` },
  { name: `Posts`, title: `Blog Posts`, hitComp: `PostHit` },
]

const Header = ({ site }) => (
  <HeaderContainer>
    <Logo to="/" title={site.title} rel="home">
      JR
    </Logo>
    <Nav />
    <Social collapse short linkStyle={navLinkStyle} />
    <Search collapse indices={searchIndices} />
  </HeaderContainer>
)

export default Header
