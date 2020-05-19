import PropTypes from 'prop-types'
import React from 'react'
import PostExcerpt from 'components/PostExcerpt'
import { PostGrid } from './styles'

const PostList = ({ posts, noText, ...rest }) => (
  <PostGrid minWidth="17em" maxWidth="24em" gap="1.5em" {...rest}>
    {posts.map(({ node }) => (
      <PostExcerpt key={node.frontmatter.slug} post={node} noText={noText} />
    ))}
  </PostGrid>
)

export default PostList

PostList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object),
}
