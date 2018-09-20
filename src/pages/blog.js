import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import CategoryList from '../components/CategoryList'
import PostsList from '../components/PostsList'

const Blog = ({ data, location }) => {
  const title = `Blog`
  const { posts, categories } = data
  const path = location.pathname
  return (
    <Global pageTitle={title} path={path}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <div>
        <CategoryList categories={categories.group} />
        {posts && <PostsList posts={posts.edges} />}
      </div>
    </Global>
  )
}

export default Blog

export const query = graphql`
  fragment categories on Query {
    categories: allMarkdownRemark {
      group(field: frontmatter___categories) {
        title: fieldValue
        totalCount
      }
    }
  }
  fragment postFields on MarkdownRemarkEdge {
    node {
      frontmatter {
        title
        slug
        date
        categories
      }
      excerpt
      timeToRead
    }
  }
  {
    posts: allMarkdownRemark(
      sort: { fields: [frontmatter___date], order: DESC }
      filter: { fileAbsolutePath: { regex: "/content/blog/" } }
    ) {
      edges {
        ...postFields
      }
    }
    ...categories
  }
`
