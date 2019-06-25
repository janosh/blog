import React from "react"
import { useStaticQuery, graphql } from "gatsby"
import { ThemeProvider } from "styled-components"

import Seo from "../Seo"
import Header from "../Header"
import Footer from "../Footer"
import theme from "../../utils/theme"
import SyntaxHighlight from "../../utils/syntaxHighlight"
import Scroll from "../Scroll"

import { GlobalStyle } from "./styles"
import { useDarkMode } from "../../hooks"

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
