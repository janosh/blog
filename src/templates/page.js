import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'

const PageTemplate = ({ data, location }) => {
  const { frontmatter, html, excerpt } = data.page
  const { title } = frontmatter
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

export const query = graphql`
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
