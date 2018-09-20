import React from 'react'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import Social from '../components/Social'
import Map from '../components/Map'

const center = { lat: 52.21, lng: 0.091 }
const mapProps = {
  options: {
    center,
    zoom: 16,
  },
  onMount: map => {
    new window.google.maps.Marker({
      position: center,
      map,
      title: 'Maxwell Centre',
    })
  },
}

const Contact = ({ location }) => {
  const path = location.pathname
  return (
    <Global layout path={path}>
      <PageTitle>
        <h1>Contact</h1>
      </PageTitle>
      <p>You can find me on any of these platforms.</p>
      <Social />
      <p>
        If you're in the area and want to meet in person, I spend most of my
        days at the Maxwell Centre. Feel free to drop by.
      </p>
      <Map id="contactMap" {...mapProps} />
    </Global>
  )
}

export default Contact
