import { graphql, useStaticQuery } from 'gatsby'
import { useScreenQuery } from 'hooks'
import React from 'react'
import DesktopNav from './Desktop'
import MobileNav from './Mobile'

export { NavLink } from './styles'

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
  // Returns true or false on client, undefined in SSR.
  const mobile = useScreenQuery(`maxPhablet`)
  if (mobile) return <MobileNav {...nav} {...props} />
  // Only render DesktopNav if screen query is false.
  if (mobile === false) return <DesktopNav {...nav} {...props} />
  // Render nothing in SSR to avoid showing DesktopNav on mobile
  // on initial page load from cleared cache.
  return null
}
