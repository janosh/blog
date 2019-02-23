import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageHeader from "../components/PageHeader"

const PageTemplate = ({ data, location }) => {
  const { frontmatter, html, excerpt } = data.page
  const { title, cover } = frontmatter
  if (cover) cover.fluid = cover.img.sharp.fluid
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageHeader img={cover}>
        <h1>{title}</h1>
      </PageHeader>
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
        ...cover
      }
      html
      excerpt
    }
  }
`
