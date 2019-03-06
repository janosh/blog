import React from "react"
import PropTypes from "prop-types"

import { TagList, Tag, TagsIcon, tagIcons } from "./styles"

const TagListComp = ({ tags, activeTag, setTag }) => (
  <TagList>
    <h2>
      <TagsIcon size="1em" />
      &nbsp; Tags
    </h2>
    {tags.map(({ title, count }) => {
      const TagIcon = tagIcons[title]
      return (
        <Tag
          key={title}
          active={activeTag === title}
          onClick={() => setTag(title)}
        >
          {TagIcon && <TagIcon size="1em" />}
          &nbsp; {title} ({count})
        </Tag>
      )
    })}
  </TagList>
)

export default TagListComp

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
