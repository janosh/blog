import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import TagList from '../components/TagList'
import PostList from '../components/PostList'

const tagTemplate = ({ data, location, title = `Blog`, pageContext }) => {
  let { posts, tags } = data
  const path = location.pathname
  const tag = pageContext.title
  tags = tags.group.map(({ title, totalCount }) => ({
    title,
    slug: `/blog/` + title.toLowerCase().replace(` `, `-`),
    totalCount,
  }))
  tags.unshift({ title: `All`, slug: `/blog`, totalCount: posts.edges.length })
  if (tag !== `All`) {
    posts.edges = posts.edges.filter(({ node }) =>
      node.frontmatter.tags.includes(tag)
    )
  }
  return (
    <Global pageTitle={title} path={path}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <div>
        <TagList tags={tags} />
        {posts && <PostList posts={posts.edges} />}
      </div>
    </Global>
  )
}

export default tagTemplate

export const query = graphql`
  {
    posts: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: [frontmatter___date], order: DESC }
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
        totalCount
      }
    }
  }
`
