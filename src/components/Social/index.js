import React from 'react'
import { StaticQuery, graphql } from 'gatsby'
import PropTypes from 'prop-types'

import { Wrapper, Container, Toggle, Link, Icons } from './styles'

const Social = ({ social, iconSize, expandOnHover }) => (
  <Wrapper>
    {expandOnHover && <Toggle size={iconSize} />}
    <Container {...{ expandOnHover }}>
      {social.map(service => {
        const Icon = Icons[service.title]
        return (
          <Link key={service.title} href={service.url}>
            <Icon size={iconSize} />
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
  iconSize: PropTypes.string.isRequired,
}

Social.defaultProps = {
  iconSize: `1em`,
}
