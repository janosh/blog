import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PostList from "../views/PostList"

const tagTemplate = ({ data, location, title = `Blog`, pageContext }) => {
  let { posts, tags } = data
  const tagTitle = pageContext.title
  const postCount = posts.edges.length
  if (tagTitle !== `All`) {
    posts.edges = posts.edges.filter(({ node }) =>
      node.frontmatter.tags.includes(tagTitle)
    )
  }
  tags = tags.group.map(tag => ({
    ...tag,
    slug: `blog/` + tag.title.toLowerCase().replace(` `, `-`),
  }))
  tags.unshift({ title: `All`, slug: `blog`, count: postCount })
  return (
    <Global pageTitle={title} path={location.pathname}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <PostList posts={posts.edges} tags={tags} />
    </Global>
  )
}

export default tagTemplate

export const query = graphql`
  {
    posts: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      edges {
        node {
          ...postFields
        }
      }
    }
    tags: allMarkdownRemark {
      group(field: frontmatter___tags) {
        title: fieldValue
        count: totalCount
      }
    }
  }
`
