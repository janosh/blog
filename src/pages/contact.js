import { graphql } from 'gatsby'
import React from 'react'
import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import Social from '../components/Social'
import { PageBody } from '../components/styles'

const ContactPage = ({ data, location }) => (
  <Global path={location.pathname}>
    <PageTitle img={data.img.sharp}>
      <h1>Contact</h1>
    </PageTitle>
    <PageBody>
      <p>You can reach me by email or on any of these platforms.</p>
      <Social size="2em" />
      <p>
        I spend most of my days at the Maxwell Centre. If you‘re in the area,
        feel free to drop by.
      </p>
      <iframe
        title="Contact Map"
        src={`https://www.google.com/maps/embed/v1/place?key=${
          process.env.GATSBY_GOOGLE_MAPS_API_KEY
        }&q=Maxwell+Centre,Cambridge,UK`}
        css="height: 80vh; width: 100%; border: 0;"
      />
    </PageBody>
  </Global>
)

export default ContactPage

export const query = graphql`
  {
    img: file(name: { eq: "mt-meru" }) {
      sharp: childImageSharp {
        fluid(maxWidth: 1800) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
