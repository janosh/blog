import React from "react"
import PropTypes from "prop-types"
import { Link } from "gatsby"

import { PreviousNext, Thumbnail, Img } from "./styles"

const PrevNext = ({ prev, next, label, slugPrefix = `` }) => {
  return (
    <PreviousNext>
      {prev && (
        <Link to={slugPrefix + prev.slug} rel="prev" css="margin-right: 1em;">
          <h3 css="text-align: left;">← Previous {label}</h3>
          <Thumbnail>
            {prev.cover.img && (
              <Img {...prev.cover.img.sharp || prev.cover.img} />
            )}
            <h4>{prev.title}</h4>
          </Thumbnail>
        </Link>
      )}
      {next && (
        <Link to={slugPrefix + next.slug} rel="next" css="margin-left: auto;">
          <h3 css="text-align: right;">Next {label} →</h3>
          <Thumbnail>
            {next.cover.img && (
              <Img {...next.cover.img.sharp || next.cover.img} />
            )}
            <h4>{next.title}</h4>
          </Thumbnail>
        </Link>
      )}
    </PreviousNext>
  )
}
export default PrevNext

PrevNext.propTypes = {
  label: PropTypes.string.isRequired,
}
