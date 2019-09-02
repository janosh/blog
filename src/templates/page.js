import { graphql } from 'gatsby'
import { MDXRenderer } from 'gatsby-plugin-mdx'
import React from 'react'
import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import { PageBody } from '../components/styles'

export default function PageTemplate({ data, location }) {
  const { frontmatter, body, excerpt } = data.page
  const { title, cover } = frontmatter
  if (cover) cover.fluid = cover.img.sharp.fluid
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover}>
        <h1>{title}</h1>
      </PageTitle>
      <PageBody>
        <MDXRenderer>{body}</MDXRenderer>
      </PageBody>
    </Global>
  )
}

export const query = graphql`
  query($slug: String!) {
    page: mdx(frontmatter: { slug: { eq: $slug } }) {
      frontmatter {
        title
        ...cover
      }
      body
      excerpt
    }
  }
`
