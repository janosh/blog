import React, { useState } from 'react'
import PropTypes from 'prop-types'

import { TagGrid, Toggle, Tag, TagsIcon, tagIcons } from './styles'

export default function TagList({ tags, activeTag, setTag }) {
  const [open, setOpen] = useState(false)
  return (
    <TagGrid open={open}>
      <h2>
        <TagsIcon size="1em" />
        &nbsp; Tags
        <Toggle open={open} onClick={() => setOpen(!open)} />
      </h2>
      {tags.map(({ title, count }) => {
        const TagIcon = tagIcons[title]
        return (
          <Tag
            open={open}
            key={title}
            active={activeTag === title}
            onClick={() => setTag(title)}
          >
            {TagIcon && <TagIcon size="1em" />}
            &nbsp; {title} ({count})
          </Tag>
        )
      })}
    </TagGrid>
  )
}

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
