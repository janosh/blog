import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PostTitle from '../components/PostTitle'

const PostTemplate = ({ data, location }) => {
  const { frontmatter, excerpt, html, ...rest } = data.post
  return (
    <Global
      pageTitle={frontmatter.title}
      path={location.pathname}
      description={excerpt}
    >
      <PostTitle {...frontmatter} {...rest} />
      <div dangerouslySetInnerHTML={{ __html: html }} />
    </Global>
  )
}

export default PostTemplate

export const query = graphql`
  fragment postFields on MarkdownRemark {
    frontmatter {
      title
      slug
      date(formatString: "MMMM DD, YYYY")
      tags
      cover {
        img {
          sharp: childImageSharp {
            fluid(maxWidth: 2500, quality: 100) {
              ...GatsbyImageSharpFluid_withWebp
            }
          }
        }
        credit
        url
      }
    }
    timeToRead
    excerpt(pruneLength: 300)
    html
  }
  query($slug: String!) {
    post: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      ...postFields
    }
  }
`
