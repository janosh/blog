import React from "react"
import PropTypes from "prop-types"

import { List, Tag } from "./styles"

const TagList = ({ tags }) => (
  <List>
    {tags.map(({ title, slug, count }) => (
      <Tag key={slug} activeClassName="active" to={slug}>
        {title} ({count})
      </Tag>
    ))}
  </List>
)

export default TagList

TagList.propTypes = {
  title: PropTypes.string,
  tags: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      count: PropTypes.number.isRequired,
    })
  ),
}
