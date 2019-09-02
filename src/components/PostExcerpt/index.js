import { Link } from 'gatsby'
import React from 'react'
import PostMeta from '../PostMeta'
import { Cover, Post } from './styles'

export default function PostExcerpt({ post, noText }) {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug, cover } = frontmatter
  if (cover && cover.img) {
    const img = cover.thumbnail || cover.img
    if (img.sharp) cover.fluid = img.sharp.fluid
    if (img.src) cover.src = img.src
  }
  return (
    <Post>
      <Link to={slug}>
        <Cover {...cover} />
      </Link>
      <h3 css="margin: 0.8em auto 0.5em;">
        <Link to={slug}>{title}</Link>
      </h3>
      <PostMeta {...{ ...frontmatter, timeToRead }} />
      {!noText && <span dangerouslySetInnerHTML={{ __html: excerpt }} />}
    </Post>
  )
}
