import React, { Fragment } from 'react'
import PropTypes from 'prop-types'

import { Meta, Categories, Category } from './styles'
import { Calendar } from 'styled-icons/octicons/Calendar'
import { Timer } from 'styled-icons/material/Timer'

const PostMeta = ({ date, categories, timeToRead, inTitle, iconSize }) => (
  <Fragment>
    <Meta inTitle={inTitle} >
      <span>
        <Calendar size={iconSize} />
        &ensp;{date}
      </span>
      <span>
        <Timer size={iconSize} />
        &ensp;{timeToRead} min read
      </span>
    </Meta>
    <Categories>{categories.map(category =>
      <Category key={category}>{category}</Category>
    )}</Categories>
  </Fragment>
)

export default PostMeta

PostMeta.propTypes = {
  date: PropTypes.string.isRequired,
  categories: PropTypes.arrayOf(PropTypes.string.isRequired).isRequired,
  timeToRead: PropTypes.number.isRequired,
  inTitle: PropTypes.bool,
}

PostMeta.defaultProps = {
  inTitle: false,
  iconSize: `1.2rem`,
}