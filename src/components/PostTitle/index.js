import React from 'react'
import PropTypes from 'prop-types'

import { Title } from './styles'
import PostMeta from '../PostMeta'

const PostTitle = ({ post: { frontmatter, timeToRead } }) => (
  <Title>
    <h1>{frontmatter.title}</h1>
    <PostMeta inTitle {...{ ...frontmatter, timeToRead }} />
  </Title>
)

export default PostTitle

PostTitle.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.object.isRequired,
    timeToRead: PropTypes.number.isRequired,
  }),
}
