import React from 'react'
import PropTypes from 'prop-types'

import { Container, Title, BackLink } from './styles'
import PostMeta from '../PostMeta'

const PostTitle = ({ post: { frontmatter, timeToRead } }) => (
  <Container>
    <Title>{frontmatter.title}</Title>
    <PostMeta inTitle {...{...frontmatter, timeToRead}} />
    <BackLink to='/blog'>Back to blog</BackLink>
  </Container>
)

export default PostTitle

PostTitle.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.object.isRequired,
    timeToRead: PropTypes.number.isRequired,
  })
}