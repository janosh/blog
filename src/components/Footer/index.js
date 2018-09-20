import React from 'react'
import { StaticQuery, graphql } from 'gatsby'
import PropTypes from 'prop-types'

import { Container } from './styles'

const Footer = ({ copyright, sourceNote }) => (
  <Container>
    <span>
      © {new Date().getFullYear()} - {copyright}
    </span>
    <span dangerouslySetInnerHTML={{ __html: sourceNote }} />
  </Container>
)

Footer.propTypes = {
  copyright: PropTypes.string.isRequired,
  sourceNote: PropTypes.string.isRequired,
}

const query = graphql`
  {
    footer: contentYaml {
      copyright
      sourceNote
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <Footer {...data.footer} {...props} />}
  />
)
