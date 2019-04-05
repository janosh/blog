import React from "react"
import { graphql } from "gatsby"
import { DiscussionEmbed } from "disqus-react"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import { PageBody } from "../components/styles"
import PostMeta from "../components/PostMeta"
import PrevNext from "../components/PrevNext"
import { disqusConfig } from "../utils/misc"

const PostTemplate = ({ data, location }) => {
  const { post, next, prev } = data
  const { frontmatter, excerpt, html, timeToRead } = post
  const { title, slug, cover } = frontmatter
  if (cover && cover.img) {
    if (cover.img.sharp) cover.fluid = cover.img.sharp.fluid
    if (cover.img.src) cover.src = cover.img.src
  }
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover} backdrop>
        <h1>{title}</h1>
        <PostMeta inTitle {...{ ...frontmatter, timeToRead }} />
      </PageTitle>
      <PageBody>
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
