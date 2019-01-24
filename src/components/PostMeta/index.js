import React from 'react'
import PropTypes from 'prop-types'

import { Meta } from './styles'
import { Calendar } from 'styled-icons/octicons/Calendar'
import { Timer } from 'styled-icons/material/Timer'

const PostMeta = ({ date, timeToRead, inTitle, iconSize }) => (
  <Meta inTitle={inTitle}>
    <span>
      <Calendar size={iconSize} />
      &ensp;
      {date}
    </span>
    <span>
      <Timer size={iconSize} />
      &ensp;
      {timeToRead} min read
    </span>
  </Meta>
)

export default PostMeta

PostMeta.propTypes = {
  date: PropTypes.string.isRequired,
  timeToRead: PropTypes.number.isRequired,
  inTitle: PropTypes.bool,
}

PostMeta.defaultProps = {
  inTitle: false,
  iconSize: `1.2em`,
}
