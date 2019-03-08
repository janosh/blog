import React, { Fragment } from "react"
import styled, { css } from "styled-components"
import { Tags } from "styled-icons/fa-solid/Tags"
import { Tag } from "styled-icons/fa-solid/Tag"

const inTitle = css`
  margin: 1.3em auto;
  width: max-content;
  a {
    color: ${props => props.theme.lightGreen};
  }
  grid-template-columns: repeat(3, auto);
  justify-items: center;
  span.tags {
    grid-column: 1/-1;
  }
`

export const Meta = styled.div`
  display: grid;
  grid-gap: 0.2em 1em;
  font-size: 0.8em;
  grid-template-columns: repeat(auto-fill, minmax(8em, max-content));
  margin-bottom: 0.5em;
  > * {
    display: flex;
    align-items: center;
  }
  ${props => props.inTitle && inTitle};
`

export const TagList = ({ tags }) => (
  <span className="tags">
    <Tags
      as={tags.length === 1 && Tag}
      css="margin-right: 0.5em; min-width: 1.1em;"
    />
    {tags.map((tag, index) => (
      <Fragment key={tag}>
        {index > 0 && `, `}
        {tag}
      </Fragment>
    ))}
  </span>
)
