import React, { Fragment } from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Link } from 'gatsby'
import { Calendar } from 'styled-icons/octicons/Calendar'
import { Tags } from 'styled-icons/fa-solid/Tags'

const PostHit = clickHandler => ({ hit }) => (
  <div>
    <Link to={`/blog/` + hit.slug} onClick={clickHandler}>
      <h3>
        <Highlight attribute="title" hit={hit} tagName="mark" />
      </h3>
    </Link>
    <div>
      <Calendar size="1em" />
      &nbsp;
      <Highlight attribute="date" hit={hit} tagName="mark" />
      &emsp;
      <Tags size="1em" />
      &nbsp;
      {hit.tags.map((tag, index) => (
        <Fragment key={tag}>
          {!!index && ', '}
          <Link to={`blog/` + tag.toLowerCase().replace(` `, `-`)}>{tag}</Link>
        </Fragment>
      ))}
    </div>
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export default PostHit
