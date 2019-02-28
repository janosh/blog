import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import PostMeta from "../components/PostMeta"

const PostTemplate = ({ data, location }) => {
  const { frontmatter, excerpt, html, timeToRead } = data.post
  const { title, date, cover } = frontmatter
  if (cover) cover.fluid = cover.img.sharp.fluid
  const meta = { date, timeToRead }
  return (
    <Global pageTitle={title} path={location.pathname} description={excerpt}>
      <PageTitle img={cover} backdrop>
        <h1>{title}</h1>
        <PostMeta inTitle {...meta} />
      </PageTitle>
      <PageBody dangerouslySetInnerHTML={{ __html: html }} />
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
