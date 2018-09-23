import React from 'react'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import Social from '../components/Social'

const Contact = ({ location }) => {
  const path = location.pathname
  return (
    <Global path={path}>
      <PageTitle>
        <h1>Contact</h1>
      </PageTitle>
      <p>You can reach me by email or on any of these platforms.</p>
      <Social size="2em" />
      <p>
        If you're in the area and want to meet in person, I spend most of my
        days at the Maxwell Centre. Feel free to drop by.
      </p>
      <iframe
        title="contactMap"
        width="100%"
        height="600px"
        frameborder="0"
        src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCMyrqYg_pCL5vvX1hPEUCd6lh_6UzNq8U
    &q=Maxwell+Centre,Cambridge,UK"
      />
    </Global>
  )
}

export default Contact
