import React from "react"
import { graphql } from "gatsby"
import { DiscussionEmbed } from "disqus-react"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import PostMeta from "../components/PostMeta"
import PrevNext from "../components/PrevNext"
import { disqusConfig } from "../utils/misc"

const PostTemplate = ({ data, location, pageContext }) => {
  const { frontmatter, excerpt, html, timeToRead } = data.post
  const { title, slug, date, cover } = frontmatter
  if (cover && cover.img) {
    if (cover.img.sharp) cover.fluid = cover.img.sharp.fluid
    if (cover.img.src) cover.src = cover.img.src
  }
  const { next, previous } = pageContext
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover} backdrop>
        <h1>{title}</h1>
        <PostMeta inTitle {...{ title, slug, date, timeToRead }} />
      </PageTitle>
      <PageBody>
        <div dangerouslySetInnerHTML={{ __html: html }} />
        <PrevNext
          prev={previous && previous.frontmatter}
          next={next && next.frontmatter}
          slugPrefix="/blog"
          label="post"
        />
        <DiscussionEmbed {...disqusConfig({ slug, title })} />
      </PageBody>
    </Global>
  )
}

export default PostTemplate

export const query = graphql`
  query($slug: String!) {
    post: markdownRemark(frontmatter: { slug: { eq: $slug } }) {
      ...post
    }
  }
`
