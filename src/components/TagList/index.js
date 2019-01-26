import React from "react"
import PropTypes from "prop-types"

import { List, Tag } from "./styles"

const TagList = ({ tags, activeTag, setTag }) => (
  <List>
    {tags.map(({ title, count }) => (
      <Tag
        key={title}
        active={activeTag === title}
        onClick={() => setTag(title)}
      >
        {title} ({count})
      </Tag>
    ))}
  </List>
)

export default TagList

TagList.propTypes = {
  activeTag: PropTypes.string.isRequired,
  setTag: PropTypes.func.isRequired,
  tags: PropTypes.arrayOf(
    PropTypes.shape({
      title: PropTypes.string.isRequired,
      count: PropTypes.number.isRequired,
    })
  ),
}
