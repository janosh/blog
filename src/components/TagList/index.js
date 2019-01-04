import React from 'react'
import PropTypes from 'prop-types'

import { List, Tag } from './styles'

const TagList = ({ title = `Tags`, tags }) => (
  <>
    <h1>{title}</h1>
    <List>
      {tags.map(({ title, slug, totalCount }) => (
        <Tag key={slug} activeClassName="active" to={slug}>
          {title} ({totalCount})
        </Tag>
      ))}
    </List>
  </>
)

export default TagList

TagList.propTypes = {
  title: PropTypes.string,
  tags: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      totalCount: PropTypes.number.isRequired,
    })
  ),
}
