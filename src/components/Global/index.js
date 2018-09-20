import { MDXProvider } from '@mdx-js/react'
import { graphql, useStaticQuery } from 'gatsby'
import React from 'react'
import SyntaxHighlight from 'utils/syntaxHighlight'
import Footer from '../Footer'
import Header from '../Header'
import { LazyPlot } from '../Plotly'
import Scroll from '../Scroll'
import Seo from '../Seo'
import { DocsGrid } from '../styles'
import { GlobalStyle } from './styles'

const components = { LazyPlot, DocsGrid }

export const Providers = ({ children }) => (
  <MDXProvider components={components}>
    {children}
    <Scroll showBelow={1500} css="position: fixed; right: 1em; bottom: 1em;" />
  </MDXProvider>
)

export function PageComponents({ children, ...rest }) {
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
    <>
      <GlobalStyle />
      <SyntaxHighlight />
      <Seo {...site} {...rest} />
      <Header {...site} />
      {children}
      <Footer />
    </>
  )
}
