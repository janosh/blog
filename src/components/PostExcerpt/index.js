import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'gatsby'

import { Article } from './styles'
import PostMeta from '../PostMeta'

const PostExcerpt = ({ post }) => {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug } = frontmatter
  return (
    <Article>
      <h1>
        <Link to={'/blog/' + slug}>{title}</Link>
      </h1>
      <PostMeta {...{ ...frontmatter, timeToRead }} />
      <p dangerouslySetInnerHTML={{ __html: excerpt }} />
    </Article>
  )
}

export default PostExcerpt

PostExcerpt.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.shape({
      title: PropTypes.string.isRequired,
      slug: PropTypes.string.isRequired,
    }),
    excerpt: PropTypes.string.isRequired,
    timeToRead: PropTypes.number.isRequired,
  }),
}
