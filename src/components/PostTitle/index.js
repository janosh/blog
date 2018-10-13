import React from 'react'
import PropTypes from 'prop-types'

import { Container, Title, Img } from './styles'
import PostMeta from '../PostMeta'

const PostTitle = ({ post: { frontmatter, timeToRead } }) => (
  <Container>
    <Img fluid={frontmatter.cover.img.fluid} />
    <Title>{frontmatter.title}</Title>
    <PostMeta inTitle {...{ ...frontmatter, timeToRead }} />
  </Container>
)

export default PostTitle

PostTitle.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.object.isRequired,
    timeToRead: PropTypes.number.isRequired,
  }),
}
