import React from 'react'
import PropTypes from 'prop-types'

import PostExcerpt from './PostExcerpt'

const PostsList = ({ posts }) => (
  <div>
    {posts.map(({ node: post }) => (
      <PostExcerpt key={post.frontmatter.slug} post={post} />
    ))}
  </div>
)

export default PostsList

PostsList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object)
}

PostsList.defaultProps = {
  posts: [],
}