import PageTitle from 'components/PageTitle'
import { PageBody } from 'components/styles'
import { graphql } from 'gatsby'
import { MDXRenderer as Mdx } from 'gatsby-plugin-mdx'
import React from 'react'

export default function PageTemplate({ data }) {
  const { frontmatter, body, excerpt } = data.page
  const { title, cover } = frontmatter
  cover.fluid = cover?.img?.sharp?.fluid
  cover.src = cover?.img?.src
  cover.alt = cover?.img?.alt
  return (
    <>
      <PageTitle img={cover}>
        <h1>{title}</h1>
      </PageTitle>
      {excerpt && ( // If excerpt is empty, so is body. Hence no need to render it.
        // Testing excerpt because body is an MDX function (always truthy).
        <PageBody>
          <Mdx>{body}</Mdx>
        </PageBody>
      )}
    </>
  )
}

export const query = graphql`
  query($slug: String!) {
    page: mdx(frontmatter: { slug: { eq: $slug } }) {
      ...page
    }
  }
`
