import React from 'react'
import PropTypes from 'prop-types'

import PostExcerpt from './PostExcerpt'

const PostList = ({ posts }) => (
  <div>
    {posts.map(({ node: post }) => (
      <PostExcerpt key={post.frontmatter.slug} post={post} />
    ))}
  </div>
)

export default PostList

PostList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object),
}

PostList.defaultProps = {
  posts: [],
}
