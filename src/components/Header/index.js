import React from "react"

import { HeaderContainer, Logo } from "./styles"
import Nav from "../Nav"
import Social from "../Social"
import Search from "../Search"
import { DarkModeToggle } from "../Toggle"
import { navLinkStyle } from "../Nav"

const searchIndices = [
  { name: `Pages`, title: `Pages`, hitComp: `PageHit` },
  { name: `Posts`, title: `Blog Posts`, hitComp: `PostHit` },
]

const Header = ({ site, darkMode, setDarkMode }) => (
  <HeaderContainer>
    <Logo to="/" title={site.title} rel="home">
      JR
    </Logo>
    <Nav />
    <DarkModeToggle {...{ darkMode, setDarkMode }} />
    <Social collapse short linkStyle={navLinkStyle} />
    <Search collapse indices={searchIndices} />
  </HeaderContainer>
)

export default Header
