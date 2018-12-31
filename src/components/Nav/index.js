import React from 'react'
import { StaticQuery, graphql } from 'gatsby'
import PropTypes from 'prop-types'

import Nav from './comp'

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
    render={data => <Nav {...data.nav} {...props} />}
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
