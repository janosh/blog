import React from 'react'
import { StaticQuery, graphql } from 'gatsby'

import { Title, Background } from './styles'

const PageTitle = ({ children, img, defaultImg, backdrop }) => (
  <>
    <Background fluid={(img && img.fluid) || defaultImg.fluid} />
    <Title backdrop={backdrop}>{children}</Title>
  </>
)

const query = graphql`
  {
    file(name: { eq: "background" }) {
      defaultImg: childImageSharp {
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
    render={data => <PageTitle {...data.file} {...props} />}
  />
)
