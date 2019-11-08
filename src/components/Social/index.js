import { graphql, useStaticQuery } from 'gatsby'
import React from 'react'
import { Container, Icons, Link, Toggle, Wrapper } from './styles'

export default function Social({ size = `1em`, collapse, linkStyle, short }) {
  let { social } = useStaticQuery(graphql`
    {
      social: allSocialYaml {
        edges {
          node {
            title
            url
          }
        }
      }
    }
  `)
  social = social.edges.map(el => el.node)
  return (
    <Wrapper>
      {collapse && <Toggle {...{ size, styles: linkStyle }} />}
      <Container {...{ collapse }}>
        {social.map(service => {
          if (short && [`Facebook`, `Youtube`].includes(service.title))
            return undefined
          const Icon = Icons[service.title]
          return (
            <Link key={service.title} href={service.url} styles={linkStyle}>
              <Icon size={size} />
            </Link>
          )
        })}
      </Container>
    </Wrapper>
  )
}
