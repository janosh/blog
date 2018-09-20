import React from 'react'
import PropTypes from 'prop-types'

import { Article, Title, TitleLink } from './styles'
import PostMeta from '../PostMeta'

const PostExcerpt = ({ post }) => {
  const { frontmatter, excerpt, timeToRead } = post
  const { title, slug } = frontmatter
  return <Article>
    <Title>
      <TitleLink to={'/blog/' + slug}>
        {title}
      </TitleLink>
    </Title>
    <PostMeta {...{...frontmatter, timeToRead}} />
    <p dangerouslySetInnerHTML={{ __html: excerpt }} />
  </Article>
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
  })
}