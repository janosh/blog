import React, { Fragment } from 'react'
import { StaticQuery, graphql } from 'gatsby'

import { Title, Background } from './styles'

const PageTitle = ({ children, file }) => (
  <Fragment>
    <Background fluid={file.img.fluid} />
    <Title>{children}</Title>
  </Fragment>
)

const query = graphql`
  {
    file(name: { eq: "background" }) {
      img: childImageSharp {
        fluid(maxWidth: 2500, quality: 100) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <PageTitle {...data} {...props} />}
  />
)
