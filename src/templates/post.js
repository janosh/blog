import React from "react"
import { graphql } from "gatsby"
import { DiscussionEmbed } from "disqus-react"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import PostMeta from "../components/PostMeta"
import PrevNext from "../components/PrevNext"

const PostTemplate = ({ data, location, pageContext }) => {
  const { frontmatter, excerpt, html, timeToRead } = data.post
  const { title, slug, date, cover } = frontmatter
  if (cover) cover.fluid = cover.img.sharp.fluid
  const meta = { date, timeToRead }
  const { next, previous } = pageContext
  const disqusConfig = {
    shortname: process.env.GATSBY_DISQUS_NAME,
    config: { identifier: slug, title },
  }
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover} backdrop>
        <h1>{title}</h1>
        <PostMeta inTitle {...meta} />
      </PageTitle>
      <PageBody>
        <div dangerouslySetInnerHTML={{ __html: html }} />
        <PrevNext
          prev={previous.frontmatter}
          next={next.frontmatter}
          slugPrefix="/blog"
          label="post"
        />
        <DiscussionEmbed {...disqusConfig} />
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
