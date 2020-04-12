import { graphql } from 'gatsby'
import { MDXRenderer as Mdx } from 'gatsby-plugin-mdx'
import React from 'react'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import { PageBody } from 'components/styles'

export default function PageTemplate({ data, location }) {
  const { frontmatter, body, excerpt } = data.page
  const { title, mdxTitle, cover } = frontmatter
  cover.fluid = cover?.img?.sharp?.fluid
  cover.src = cover?.img?.src
  cover.alt = cover?.img?.alt
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover}>
        {mdxTitle ? <Mdx>{mdxTitle.childMdx.body}</Mdx> : <h1>{title}</h1>}
      </PageTitle>
      {excerpt && ( // If excerpt is empty, so is body. Hence no need to render it.
        // Testing excerpt because body is an MDX function (always truthy).
        <PageBody>
          <Mdx>{body}</Mdx>
        </PageBody>
      )}
    </Global>
  )
}

export const query = graphql`
  query($slug: String!) {
    page: mdx(frontmatter: { slug: { eq: $slug } }) {
      ...page
    }
  }
`
