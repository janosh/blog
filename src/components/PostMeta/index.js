import React from "react"
import PropTypes from "prop-types"
import { Link } from "gatsby"
import { CommentCount } from "disqus-react"

import { Meta, TagList } from "./styles"
import { Calendar } from "styled-icons/octicons/Calendar"
import { Timer } from "styled-icons/material/Timer"
import { Comments } from "styled-icons/fa-solid/Comments"
import { disqusConfig } from "../../utils/misc"

const PostMeta = ({ title, slug, date, timeToRead, tags, inTitle = false }) => (
  <Meta inTitle={inTitle}>
    <span>
      <Calendar size="1.2em" />
      &ensp;
      {date}
    </span>
    <span>
      <Timer size="1.2em" />
      &ensp;
      {timeToRead} min read
    </span>
    <span>
      <Comments size="1.2em" />
      &ensp;
      <Link to={`/blog` + slug + `#disqus_thread`}>
        <CommentCount {...disqusConfig({ slug, title })} />
      </Link>
    </span>
    <TagList tags={tags} />
  </Meta>
)

export default PostMeta

PostMeta.propTypes = {
  date: PropTypes.string.isRequired,
  timeToRead: PropTypes.number.isRequired,
  inTitle: PropTypes.bool,
}
