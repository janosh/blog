import React from 'react'
import { Highlight, Snippet } from 'react-instantsearch-dom'
import { Link } from 'gatsby'

const PageHit = clickHandler => ({ hit }) => (
  <div>
    <Link to={hit.slug} onClick={clickHandler}>
      <h3>
        <Highlight attribute="title" hit={hit} tagName="mark" />
      </h3>
    </Link>
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export default PageHit
