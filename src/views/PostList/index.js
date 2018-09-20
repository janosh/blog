import React from 'react'
import PostExcerpt from 'components/PostExcerpt'
import { PostGrid } from './styles'

export default function PostList({ posts, noText, ...rest }) {
  return (
    <PostGrid minWidth="17em" maxWidth="24em" gap="1.5em" {...rest}>
      {posts.map(post => (
        <PostExcerpt key={post.frontmatter.slug} post={post} noText={noText} />
      ))}
    </PostGrid>
  )
}
