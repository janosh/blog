import { DiscussionEmbed } from 'disqus-react'
import { graphql } from 'gatsby'
import { MDXRenderer } from 'gatsby-plugin-mdx'
import React from 'react'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import PostMeta from 'components/PostMeta'
import PrevNext from 'components/PrevNext'
import { PageBody } from 'components/styles'
import Toc from 'components/Toc'

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

export default function PostTemplate({ data, location }) {
  const { post, next, prev } = data
  const { frontmatter, excerpt, body, timeToRead } = post
  const { title, slug, cover, showToc } = frontmatter
  if (cover && cover.img) {
    if (cover.img.sharp) cover.fluid = cover.img.sharp.fluid
    if (cover.img.src) cover.src = cover.img.src
  }
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover}>
        <PostTitle {...frontmatter} />
        <PostMeta inTitle {...{ ...frontmatter, timeToRead }} />
      </PageTitle>
      <PageBody as="div">
        {showToc && <Toc />}
        <main>
          <MDXRenderer>{body}</MDXRenderer>
        </main>
        <DiscussionEmbed {...disqusConfig({ slug, title })} />
        <PrevNext
          prev={prev && prev.frontmatter}
          next={next && next.frontmatter}
          label="post"
        />
      </PageBody>
    </Global>
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
