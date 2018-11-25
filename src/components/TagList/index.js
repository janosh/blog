import React, { Fragment } from 'react'
import PropTypes from 'prop-types'

import { List, TagLink } from './styles'

const Tag = ({ title, slug, totalCount }) => (
  <TagLink activeClassName="active" to={slug}>
    {title} ({totalCount})
  </TagLink>
)

const TagList = ({ title, tags }) => (
  <Fragment>
    <h1>{title}</h1>
    <List>
      {tags.map(tag => (
        <Tag key={tag.slug} {...tag} />
      ))}
    </List>
  </Fragment>
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

TagList.defaultProps = {
  title: `Tags`,
}
