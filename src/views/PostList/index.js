import React from "react"
import PropTypes from "prop-types"

import PostExcerpt from "../../components/PostExcerpt"

import { PostGrid } from "./styles"

const PostList = ({ posts }) => (
  <PostGrid minWidth="17em" maxWidth="24em" gap="1.5em">
    {posts.map(({ node }) => (
      <PostExcerpt key={node.frontmatter.slug} post={node} />
    ))}
  </PostGrid>
)

export default PostList

PostList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object),
}
