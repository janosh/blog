import { Link } from 'gatsby'
import PropTypes from 'prop-types'
import React from 'react'
import { Img, PreviousNext, Thumbnail } from './styles'

const PrevNext = ({ prev, next, label, slugPrefix = `` }) => (
  <PreviousNext>
    {prev && (
      <Link to={slugPrefix + prev.slug} rel="prev" css="margin-right: 1em;">
        <h3 css="text-align: left;">← Previous {label}</h3>
        <Thumbnail>
          <Img {...prev.cover?.img} />
          <h4>{prev.title}</h4>
        </Thumbnail>
      </Link>
    )}
    {next && (
      <Link to={slugPrefix + next.slug} rel="next" css="margin-left: auto;">
        <h3 css="text-align: right;">Next {label} →</h3>
        <Thumbnail>
          <Img {...next.cover?.img} />
          <h4>{next.title}</h4>
        </Thumbnail>
      </Link>
    )}
  </PreviousNext>
)

export default PrevNext

PrevNext.propTypes = {
  label: PropTypes.string.isRequired,
}
