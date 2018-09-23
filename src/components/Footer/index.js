import React from 'react'
import { StaticQuery, graphql } from 'gatsby'
import PropTypes from 'prop-types'

import { FooterContainer, Cpr, Source, PoweredBy } from './styles'

const Footer = ({ footer, logos }) => {
  const { copyright, sourceNote, poweredBy } = footer
  return (
    <FooterContainer>
      <Cpr>
        © {new Date().getFullYear()} - {copyright}
      </Cpr>
      <Source dangerouslySetInnerHTML={{ __html: sourceNote }} />
      <PoweredBy>
        Powered by
        {poweredBy.map(({ url, title }, index) => (
          <a key={title} href={url}>
            <img src={logos.edges[index].node.src} alt={title} />
          </a>
        ))}
      </PoweredBy>
    </FooterContainer>
  )
}

Footer.propTypes = {
  footer: PropTypes.object.isRequired,
  logos: PropTypes.object.isRequired,
}

const query = graphql`
  {
    footer: footerYaml {
      copyright
      sourceNote
      poweredBy {
        url
        title
      }
    }
    logos: allFile(
      filter: { dir: { regex: "/footer/logos/" } }
      sort: { fields: name }
    ) {
      edges {
        node {
          src: publicURL
        }
      }
    }
  }
`

export default props => (
  <StaticQuery query={query} render={data => <Footer {...data} {...props} />} />
)
