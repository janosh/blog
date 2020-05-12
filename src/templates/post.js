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

const PostTitle = ({ title, subtitle }) =>
  subtitle ? (
    <div css="padding: 0.3em 1em; > * { margin: 0;}">
      <h1>{title}</h1>
      <hr css="margin: 0.3em 0;" />
      <h2>{subtitle}</h2>
    </div>
  ) : (
    <h1>{title}</h1>
  )

function flattenCovers(fmatters) {
  fmatters.forEach(f => {
    f.cover = { ...f.cover, ...f?.cover?.img?.sharp, ...f?.cover?.img }
    delete f.cover?.img
  })
}

export default function PostTemplate({ data }) {
  const { post, next, prev } = data
  flattenCovers([post, next, prev].filter(p => p).map(p => p.frontmatter))
  const { frontmatter, body, timeToRead } = post
  const { title, slug, cover, showToc } = frontmatter
  return (
    <>
      <PageTitle img={cover}>
        <PostTitle {...frontmatter} />
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
  query($slug: String!, $prevSlug: String!, $nextSlug: String!) {
    post: mdx(frontmatter: { slug: { eq: $slug } }) {
      ...page
    }
    next: mdx(frontmatter: { slug: { eq: $nextSlug } }) {
      ...page
    }
    prev: mdx(frontmatter: { slug: { eq: $prevSlug } }) {
      ...page
    }
  }
`
