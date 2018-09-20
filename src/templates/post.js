import PageTitle from 'components/PageTitle'
import PostMeta from 'components/PostMeta'
import PrevNext from 'components/PrevNext'
import { PageBody } from 'components/styles'
import Toc from 'components/Toc'
import { DiscussionEmbed } from 'disqus-react'
import { graphql } from 'gatsby'
import { MDXRenderer } from 'gatsby-plugin-mdx'
import React from 'react'

export const disqusConfig = ({ slug, title }) => ({
  shortname: process.env.GATSBY_DISQUS_NAME,
  config: { identifier: slug, title },
})

export default function PostTemplate({ data }) {
  const { post, next, prev } = data
  const { frontmatter, body, timeToRead } = post
  const { title, slug, cover, showToc } = frontmatter
  return (
    <>
      <PageTitle {...cover}>
        <h1>{title}</h1>
        <PostMeta inTitle {...{ ...frontmatter, timeToRead }} />
      </PageTitle>
      <PageBody>
        {showToc && <Toc />}
        <MDXRenderer>{body}</MDXRenderer>
        <DiscussionEmbed {...disqusConfig({ slug, title })} />
        <PrevNext prev={prev?.frontmatter} next={next?.frontmatter} label="post" />
      </PageBody>
    </>
  )
}

export const query = graphql`
  fragment adjacent on Mdx {
    frontmatter {
      title
      slug
      ...cover
    }
  }
  query($slug: String!, $prevSlug: String!, $nextSlug: String!) {
    post: mdx(frontmatter: { slug: { eq: $slug } }) {
      ...page
    }
    next: mdx(frontmatter: { slug: { eq: $nextSlug } }) {
      ...adjacent
    }
    prev: mdx(frontmatter: { slug: { eq: $prevSlug } }) {
      ...adjacent
    }
  }
`
