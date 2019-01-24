import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'gatsby'

import { Article, Img, Title, Excerpt } from './styles'
import PostMeta from '../PostMeta'

const PostExcerpt = ({ post }) => {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug, cover } = frontmatter
  return (
    <Article>
      {cover && <Img fluid={cover.img.fluid} />}
      <Title>
        <Link to={`blog/` + slug}>{title}</Link>
      </Title>
      <PostMeta {...{ ...frontmatter, timeToRead }} />
      <Excerpt dangerouslySetInnerHTML={{ __html: excerpt }} />
    </Article>
  )
}

export default PostExcerpt

PostExcerpt.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.shape({
      title: PropTypes.string.isRequired,
      slug: PropTypes.string.isRequired,
    }),
    excerpt: PropTypes.string.isRequired,
    timeToRead: PropTypes.number.isRequired,
  }),
}
