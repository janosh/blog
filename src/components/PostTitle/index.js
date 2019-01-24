import React from 'react'
import PropTypes from 'prop-types'

import { Container, Title, Img, CoverCredit } from './styles'
import PostMeta from '../PostMeta'

const PostTitle = ({ cover, coverCredit, coverUrl, title, ...rest }) => (
  <Container>
    <Img fluid={cover.img.fluid} />
    <Title>{title}</Title>
    <PostMeta inTitle {...rest} />
    {coverCredit && (
      <CoverCredit>
        Credit: <a href={coverUrl}>{coverCredit}</a>
      </CoverCredit>
    )}
  </Container>
)

export default PostTitle

PostTitle.propTypes = {
  post: PropTypes.shape({
    frontmatter: PropTypes.object.isRequired,
    timeToRead: PropTypes.number.isRequired,
  }),
}
