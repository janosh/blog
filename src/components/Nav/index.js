import { graphql, useStaticQuery } from 'gatsby'
import React from 'react'
import { useScreenQuery } from 'hooks/useMediaQuery'
import DesktopNav from './Desktop'
import MobileNav from './Mobile'

export { NavLink, navLinkStyle } from './styles'

export default function Nav(props) {
  const { nav } = useStaticQuery(graphql`
    {
      nav: file(base: { eq: "nav.yml" }) {
        nav: childrenNavYaml {
          title
          url
        }
      }
    }
  `)
  return useScreenQuery(`maxPhablet`) ? (
    <MobileNav {...nav} {...props} />
  ) : (
    <DesktopNav {...nav} {...props} />
  )
}
