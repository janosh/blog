import React from "react"
import { Link } from "gatsby"

import { Post, Cover } from "./styles"
import PostMeta from "../PostMeta"

const PostExcerpt = ({ post }) => {
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
      <main>
        <h3>
          <Link to={`/blog` + slug}>{title}</Link>
        </h3>
        <PostMeta {...{ ...frontmatter, timeToRead }} />
        <p dangerouslySetInnerHTML={{ __html: excerpt }} />
      </main>
    </Post>
  )
}

export default PostExcerpt
