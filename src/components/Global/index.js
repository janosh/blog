import React from 'react'
import { StaticQuery, graphql } from 'gatsby'
import { ThemeProvider } from 'styled-components'
import PropTypes from 'prop-types'

import Seo from '../Seo'
import Header from '../Header'
import Footer from '../Footer'
import theme from '../../utils/theme'
import SyntaxHighlight from '../../utils/syntaxHighlight'
import Scroll from '../Scroll'

import { GlobalStyle } from './styles'

const Global = ({ children, site, ...rest }) => (
  <ThemeProvider theme={theme}>
    <>
      <Seo site={site.meta} {...rest} />
      <GlobalStyle />
      <SyntaxHighlight />
      <Header site={site.meta} />
      {children}
      <Footer />
      <Scroll
        showBelow={1500}
        css="position: fixed; right: 1em; bottom: 1em;"
      />
    </>
  </ThemeProvider>
)

Global.propTypes = {
  children: PropTypes.node.isRequired,
}

const query = graphql`
  {
    site {
      meta: siteMetadata {
        title
        url: siteUrl
        description
      }
    }
  }
`

export default props => (
  <StaticQuery query={query} render={data => <Global {...data} {...props} />} />
)
