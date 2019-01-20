import React from 'react'
import PropTypes from 'prop-types'
import { Link as GatsbyLink } from 'gatsby'

const Link = ({ to, children, ...rest }) =>
  to.startsWith(`/`) ? (
    <GatsbyLink {...rest}>{children}</GatsbyLink>
  ) : (
    <a {...rest} href={to}>
      {children}
    </a>
  )

export default Link

Link.propTypes = {
  to: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired,
}
