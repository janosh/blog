import React from "react"
import { Link } from "gatsby"

import { Post, Cover } from "./styles"
import PostMeta from "../PostMeta"

const PostExcerpt = ({ post, noText }) => {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug, cover } = frontmatter
  if (cover && cover.img) {
    if (cover.img.sharp) cover.fluid = cover.img.sharp.fluid
    if (cover.img.src) cover.src = cover.img.src
  }
  return (
    <Post>
      <Link to={`/blog` + slug}>
        <Cover {...cover} />
      </Link>
      <h3 css="margin: 0.8em auto 0.5em;">
        <Link to={`/blog` + slug}>{title}</Link>
      </h3>
      <PostMeta {...{ ...frontmatter, timeToRead }} />
      {!noText && <span dangerouslySetInnerHTML={{ __html: excerpt }} />}
    </Post>
  )
}

export default PostExcerpt
