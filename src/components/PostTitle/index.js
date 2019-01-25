import React from "react"
import PropTypes from "prop-types"

import { Container, Title, Img, CoverCredit } from "./styles"
import PostMeta from "../PostMeta"

const PostTitle = ({ cover, title, ...rest }) => (
  <Container>
    <Img fluid={cover.img.sharp.fluid} />
    <Title>{title}</Title>
    <PostMeta inTitle {...rest} />
    {cover.credit && (
      <CoverCredit>
        Credit: <a href={cover.url}>{cover.credit}</a>
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
