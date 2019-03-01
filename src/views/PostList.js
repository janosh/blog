import React from "react"
import PropTypes from "prop-types"

import Grid from "../components/styles/Grid"
import PostExcerpt from "../components/PostExcerpt"

const PostList = ({ posts, className }) => (
  <Grid minWidth="17em" maxWidth="24em" gap="1.5em" className={className}>
    {posts.map(({ node }) => (
      <PostExcerpt key={node.frontmatter.slug} post={node} />
    ))}
  </Grid>
)

export default PostList

PostList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object),
}
