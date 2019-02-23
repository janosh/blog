import React from "react"
import { Link } from "gatsby"

import { Post, Cover } from "./styles"
import PostMeta from "../PostMeta"

const PostExcerpt = ({ post }) => {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug, cover } = frontmatter
  return (
    <Post>
      {cover && cover.img && (
        <Link to={`/blog` + slug}>
          <Cover fluid={cover.img.sharp.fluid} />
        </Link>
      )}
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
