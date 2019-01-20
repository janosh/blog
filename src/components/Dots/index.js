import React from 'react'
import PropTypes from 'prop-types'

import { DotsContainer, Dot } from './styles'

const Dots = ({ n, current, onClick, size, ...rest }) => (
  <DotsContainer {...rest}>
    {Array.apply(null, { length: n }).map((dot, index) => (
      <Dot
        key={index}
        active={index === current}
        onClick={() => onClick(index)}
        size={size}
      />
    ))}
  </DotsContainer>
)

export default Dots

Dots.propTypes = {
  n: PropTypes.number.isRequired,
  current: PropTypes.number.isRequired,
  onClick: PropTypes.func.isRequired,
}
