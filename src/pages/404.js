import { graphql, Link } from 'gatsby'
import React from 'react'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import { theme } from 'utils/theme'

const PageNotFound = ({ data, location }) => (
  <Global path={location.pathname}>
    <PageTitle img={data.file.img}>
      <h2>Oops, this page doesn&apos;t exist</h2>
      <Link to="/" css={`color:` + theme.orange}>
        Back to landing page
      </Link>
    </PageTitle>
  </Global>
)

export default PageNotFound

export const query = graphql`
  {
    file(name: { eq: "tasmania" }) {
      img: childImageSharp {
        fluid(maxWidth: 2000) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
