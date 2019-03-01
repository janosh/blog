import React from "react"
import { graphql, Link } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"

const PageNotFound = ({ data, location }) => (
  <Global margin="0" transparent path={location.pathname}>
    <PageTitle img={data.file.img}>
      <h2>Oops, this page doesn&apos;t exist</h2>
      <h3>
        <Link to="/">Back to landing page</Link>
      </h3>
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
