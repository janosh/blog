import React from 'react'
import PropTypes from 'prop-types'

import { Title } from './styles'

const LandingTitle = ({ children }) => <Title>{children}</Title>

export default LandingTitle

LandingTitle.propTypes = {
  children: PropTypes.node.isRequired,
}
