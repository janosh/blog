import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PostTitle from '../components/PostTitle'

import 'katex/dist/katex.min.css'

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
  fragment postFields on MarkdownRemark {
    frontmatter {
      title
      slug
      date(formatString: "MMMM DD, YYYY")
      categories
      cover {
        img: childImageSharp {
          fluid(maxWidth: 2500, quality: 100) {
            ...GatsbyImageSharpFluid_withWebp
          }
        }
      }
    }
    timeToRead
    excerpt
    html
  }
  query($slug: String!) {
    post: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      ...postFields
    }
  }
`
