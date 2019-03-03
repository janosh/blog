import React from "react"
import PropTypes from "prop-types"

import { Link } from "gatsby"

const PrevNext = ({ prev, next, label, slugPrefix = `` }) => (
  <div css="display: flex; justify-content: space-between; flex-wrap: wrap; margin: 2em 0;">
    {prev && (
      <div css="margin-bottom: 1em;">
        <h4 css="margin: 0;">Previous {label}</h4>
        <Link to={slugPrefix + prev.slug} rel="prev">
          ← {prev.title}
        </Link>
      </div>
    )}
    {next && (
      <div css="margin-left: auto; padding-left: 1em; text-align: right;">
        <h4 css="margin: 0;">Next {label}</h4>
        <Link to={slugPrefix + next.slug} rel="next">
          {next.title} →
        </Link>
      </div>
    )}
  </div>
)

export default PrevNext

PrevNext.propTypes = {
  label: PropTypes.string.isRequired,
}
