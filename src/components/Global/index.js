import { graphql, useStaticQuery } from 'gatsby'
import PropTypes from 'prop-types'
import React from 'react'
import { ThemeProvider } from 'styled-components'
import { useDarkMode } from '../../hooks'
import SyntaxHighlight from '../../utils/syntaxHighlight'
import theme from '../../utils/theme'
import Footer from '../Footer'
import Header from '../Header'
import Scroll from '../Scroll'
import Seo from '../Seo'
import { GlobalStyle } from './styles'

export default function Global({ children, ...rest }) {
  const darkMode = useDarkMode()[0]
  const { site } = useStaticQuery(graphql`
    {
      site {
        site: siteMetadata {
          title
          url
          description
        }
      }
    }
  `)
  return (
    <ThemeProvider theme={theme(darkMode)}>
      <>
        <Seo {...site} {...rest} />
        <GlobalStyle />
        <SyntaxHighlight />
        <Header {...site} />
        {children}
        <Footer />
        <Scroll
          showBelow={1500}
          css="position: fixed; right: 1em; bottom: 1em;"
        />
      </>
    </ThemeProvider>
  )
}

Global.propTypes = {
  children: PropTypes.node.isRequired,
}
