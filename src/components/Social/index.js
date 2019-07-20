import { graphql, StaticQuery } from 'gatsby'
import PropTypes from 'prop-types'
import React from 'react'
import { Container, Icons, Link, Toggle, Wrapper } from './styles'

const Social = ({ social, size, collapse, linkStyle, short }) => (
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

const query = graphql`
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
`

export default props => (
  <StaticQuery
    query={query}
    render={data => (
      <Social social={data.social.edges.map(({ node }) => node)} {...props} />
    )}
  />
)

Social.propTypes = {
  social: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      url: PropTypes.string.isRequired,
    })
  ).isRequired,
  size: PropTypes.string.isRequired,
}

Social.defaultProps = {
  size: `1em`,
}
