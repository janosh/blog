import React from "react"
import { graphql, Link } from "gatsby"
import { DiscussionEmbed } from "disqus-react"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import PostMeta from "../components/PostMeta"

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
        <div css="display: flex; justify-content: space-between; flex-wrap: wrap; margin: 2em 0;">
          {previous && (
            <div css="margin-bottom: 1em;">
              <h4 css="margin: 0;">Previous post</h4>
              <Link to={`/blog` + previous.frontmatter.slug} rel="prev">
                ← {previous.frontmatter.title}
              </Link>
            </div>
          )}
          {next && (
            <div css="margin-left: auto; padding-left: 1em; text-align: right;">
              <h4 css="margin: 0;">Next post</h4>
              <Link to={`/blog` + next.frontmatter.slug} rel="next">
                {next.frontmatter.title} →
              </Link>
            </div>
          )}
        </div>
        <DiscussionEmbed {...disqusConfig} css="margin-top: 5em;" />
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
