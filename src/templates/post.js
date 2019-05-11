import React from 'react'
import { graphql } from 'gatsby'
import { DiscussionEmbed } from 'disqus-react'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import { PageBody } from '../components/styles'
import PostMeta from '../components/PostMeta'
import PrevNext from '../components/PrevNext'
import Toc from '../components/Toc'
import { disqusConfig } from '../utils'

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

const PostTemplate = ({ data, location }) => {
  const { post, next, prev } = data
  const { frontmatter, excerpt, html, timeToRead, headings, toc } = post
  const meta = { ...frontmatter, timeToRead }
  const { title, slug, cover, showToc } = frontmatter
  if (cover && cover.img) {
    if (cover.img.sharp) cover.fluid = cover.img.sharp.fluid
    if (cover.img.src) cover.src = cover.img.src
  }
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover} backdrop>
        <PostTitle {...frontmatter} />
        <PostMeta inTitle {...meta} />
      </PageTitle>
      <PageBody>
        {showToc && <Toc {...{ headings, toc }} />}
        <div dangerouslySetInnerHTML={{ __html: html }} />
        <DiscussionEmbed {...disqusConfig({ slug, title })} />
        <PrevNext
          prev={prev && prev.frontmatter}
          next={next && next.frontmatter}
          slugPrefix="/blog"
          label="post"
        />
      </PageBody>
    </Global>
  )
}

export default PostTemplate

export const query = graphql`
  query($slug: String!, $prevSlug: String!, $nextSlug: String!) {
    post: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      ...post
    }
    next: markdownRemark(frontmatter: { slug: { eq: $nextSlug } }) {
      ...post
    }
    prev: markdownRemark(frontmatter: { slug: { eq: $prevSlug } }) {
      ...post
    }
  }
`
