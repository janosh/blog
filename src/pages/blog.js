import React, { useState } from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import TagList from "../components/TagList"
import PostList from "../views/PostList"

const tagTemplate = ({ data, location, title = `Blog` }) => {
  const { posts, tags } = data
  const [tag, setTag] = useState(`All`)
  const filteredPosts =
    tag === `All`
      ? posts.edges
      : posts.edges.filter(({ node }) => node.frontmatter.tags.includes(tag))
  if (!tags.group.map(tag => tag.title).includes(`All`))
    tags.group.unshift({ title: `All`, count: posts.edges.length })
  return (
    <Global pageTitle={title} path={location.pathname}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <TagList tags={tags.group} activeTag={tag} setTag={setTag} />
      <PostList posts={filteredPosts} />
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
