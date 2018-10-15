import React from 'react'
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
    <p>
      <Calendar size="1em" />
      &nbsp;
      <Highlight attribute="date" hit={hit} tagName="mark" />
      &emsp;
      <Tags size="1em" />
      {hit.categories.map(category => (
        <Link
          key={category}
          to={`/blog/` + category.toLowerCase().replace(` `, `-`)}
        >
          &nbsp;
          {category}
        </Link>
      ))}
    </p>
    <Snippet attribute="excerpt" hit={hit} tagName="mark" />
  </div>
)

export default PostHit
