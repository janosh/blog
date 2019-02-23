import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageHeader from "../components/PageHeader"
import Social from "../components/Social"

const ContactPage = ({ data, location }) => (
  <Global path={location.pathname}>
    <PageHeader img={data.img.sharp}>
      <h1>Contact</h1>
    </PageHeader>
    <p>You can reach me by email or on any of these platforms.</p>
    <Social size="2em" />
    <p>
      I spend most of my days at the Maxwell Centre. If you‘re in the area, feel
      free to drop by.
    </p>
    <iframe
      title="contactMap"
      width="100%"
      height="600px"
      frameBorder="0"
      src={`https://www.google.com/maps/embed/v1/place?key=${
        process.env.GATSBY_GOOGLE_MAPS_API_KEY
      }&q=Maxwell+Centre,Cambridge,UK`}
    />
  </Global>
)

export default ContactPage

export const query = graphql`
  {
    img: file(name: { eq: "mt-meru" }) {
      sharp: childImageSharp {
        fluid(quality: 100, maxWidth: 2000) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
