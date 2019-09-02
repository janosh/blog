import { Link } from 'gatsby'
import React, { Fragment } from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Tags } from 'styled-icons/fa-solid/Tags'
import { Calendar } from 'styled-icons/octicons/Calendar'

const Root = ({ hit, clickHandler, children }) => (
  <div>
    <Link to={hit.slug} onClick={clickHandler}>
      <h4>
        <Highlight attribute="title" hit={hit} tagName="mark" />
      </h4>
    </Link>
    {children}
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export const PageHit = clickHandler => ({ hit }) => (
  <Root {...{ clickHandler, hit }} />
)

export const PostHit = clickHandler => ({ hit }) => (
  <Root {...{ clickHandler, hit }}>
    <div>
      <Calendar size="1em" />
      &nbsp;
      <Highlight attribute="date" hit={hit} tagName="mark" />
      &emsp;
      <Tags size="1em" />
      &nbsp;
      {hit.tags.map((tag, index) => (
        <Fragment key={tag}>
          {index > 0 && `, `}
          {tag}
        </Fragment>
      ))}
    </div>
  </Root>
)
