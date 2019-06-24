import React from "react"
import { graphql, Link } from "gatsby"

import { theme } from "../utils/theme"
import Global from "../components/Global"
import PageTitle from "../components/PageTitle"

const PageNotFound = ({ data, location }) => (
  <Global margin="0" transparent path={location.pathname}>
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
