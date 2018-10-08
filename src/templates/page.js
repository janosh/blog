import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'

import 'katex/dist/katex.min.css'

const PageTemplate = ({ data, location }) => {
  const {
    frontmatter: { title },
    html,
    excerpt,
  } = data.page
  return (
    <Global
      layout
      pageTitle={title}
      path={location.pathname}
      description={excerpt}
    >
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <article dangerouslySetInnerHTML={{ __html: html }} />
    </Global>
  )
}

export default PageTemplate

export const pageQuery = graphql`
  query($slug: String!) {
    page: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      frontmatter {
        title
      }
      html
      excerpt
    }
  }
`
