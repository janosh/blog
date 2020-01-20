import { graphql, useStaticQuery } from 'gatsby'
import React from 'react'
import { FooterContainer, PoweredBy } from './styles'
import Rss from '../Rss'

export default function Footer() {
  const { footer, logos } = useStaticQuery(graphql`
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
  `)
  const { copyright, sourceNote, poweredBy } = footer
  return (
    <FooterContainer>
      <span css="grid-area: copyright;">
        © {new Date().getFullYear()} - {copyright}
        &emsp; <Rss />
      </span>
      <span
        css="grid-area: source;"
        dangerouslySetInnerHTML={{ __html: sourceNote }}
      />
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
