import React from 'react'
import PropTypes from 'prop-types'

import About from '../About'
import { Title, Hello, Me } from './styles'

const LandingTitle = ({ me }) => (
  <Title>
    <Me fluid={me.img.fluid} />
    <Hello>
      <h1>Hi there!</h1>
      <h3>Welcome to my site. My name is Janosh.</h3>
    </Hello>
    <About />
  </Title>
)

export default LandingTitle

LandingTitle.propTypes = {
  me: PropTypes.object.isRequired,
}
