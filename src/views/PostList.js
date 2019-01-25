import React from "react"
import PropTypes from "prop-types"

import Grid from "../components/styles/Grid"
import TagList from "../components/TagList"
import PostExcerpt from "../components/PostExcerpt"

const wideLayout = `grid-column: 2 / -2;`

const PostList = ({ posts, tags }) => (
  <>
    <TagList tags={tags} />
    <Grid minWidth="17em" maxWidth="24em" gap="1.5em" css={wideLayout}>
      {posts.map(({ node }) => (
        <PostExcerpt key={node.frontmatter.slug} post={node} />
      ))}
    </Grid>
  </>
)

export default PostList

PostList.propTypes = {
  posts: PropTypes.arrayOf(PropTypes.object),
}
