import React from 'react'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'

const Photography = ({ location }) => {
  const path = location.pathname
  return (
    <Global path={path}>
      <PageTitle>
        <h1>Photography</h1>
      </PageTitle>
      <p>Coming soon!</p>
    </Global>
  )
}

export default Photography
