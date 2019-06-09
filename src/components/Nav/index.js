import React from "react"
import { StaticQuery, graphql } from "gatsby"
import PropTypes from "prop-types"

import { useScreenQuery } from "../../hooks/useMediaQuery"

import MobileNav from "./Mobile"
import DesktopNav from "./Desktop"
export { navLinkStyle, NavLink } from "./styles"

const Nav = props =>
  useScreenQuery(`maxPhablet`) ? (
    <MobileNav {...props} />
  ) : (
    <DesktopNav {...props} />
  )

const query = graphql`
  {
    nav: file(base: { eq: "nav.yml" }) {
      nav: childrenNavYaml {
        title
        url
      }
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <Nav {...data.nav} {...props} role="navigation" />}
  />
)

Nav.propTypes = {
  nav: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      url: PropTypes.string.isRequired,
    })
  ).isRequired,
}
