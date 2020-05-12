import React, { Fragment } from 'react'
import styled, { css } from 'styled-components'
import { Tag, Tags } from 'styled-icons/fa-solid'

const inTitle = css`
  margin: 1.3em auto;
  width: max-content;
  justify-content: center;
  max-width: 80vw;
`

export const Meta = styled.div`
  display: flex;
  flex-wrap: wrap;
  font-size: 0.8em;
  margin: 0.5em 0;
  > * {
    display: flex;
    align-items: center;
  }
  > :not(:last-child) {
    margin-right: 1em;
  }
  ${props => props.inTitle && inTitle};
`

export const TagList = ({ tags }) => (
  <span className="tags">
    <Tags
      as={tags.length === 1 && Tag}
      css="margin-right: 0.5em; width: 1.1em; min-width: 1.1em;"
    />
    {tags.map((tag, index) => (
      <Fragment key={tag}>
        {index > 0 && `, `}
        {tag}
      </Fragment>
    ))}
  </span>
)
