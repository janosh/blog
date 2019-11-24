import React from 'react'
import DarkMode from '../DarkMode'
import Nav from '../Nav'
import Search from '../Search'
import { HeaderContainer, Logo } from './styles'

const searchIndices = [
  { name: `Pages`, title: `Pages` },
  { name: `Posts`, title: `Blog Posts`, type: `postHit` },
]

export default function Header({ site }) {
  return (
    <HeaderContainer>
      <Logo to="/" title={site.title} rel="home">
        JR
      </Logo>
      <Nav />
      <DarkMode />
      <Search indices={searchIndices} />
    </HeaderContainer>
  )
}
