import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PostTitle from '../components/PostTitle'

const PostTemplate = ({ data, location }) => {
  const { frontmatter, excerpt, html } = data.post
  const path = location.pathname
  return (
    <Global pageTitle={frontmatter.title} path={path} description={excerpt}>
      <PostTitle post={data.post} />
      <div dangerouslySetInnerHTML={{ __html: html }} />
    </Global>
  )
}

export default PostTemplate

export const postQuery = graphql`
  query($slug: String!) {
    post: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      frontmatter {
        title
        slug
        date
        categories
      }
      timeToRead
      excerpt
      html
    }
  }
`
