import React from 'react'
import DarkToggle from '../DarkToggle'
import Nav from '../Nav'
import Search from '../Search'
import { HeaderDiv, Logo } from './styles'

const searchIndices = [
  { name: `Pages`, title: `Pages` },
  { name: `Posts`, title: `Blog Posts`, type: `postHit` },
]

export default function Header({ site }) {
  return (
    <HeaderDiv>
      <Logo to="/" title={site.title} rel="home">
        JR
      </Logo>
      <Nav />
      <DarkToggle />
      <Search indices={searchIndices} />
    </HeaderDiv>
  )
}
