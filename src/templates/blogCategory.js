import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import CategoryList from '../components/CategoryList'
import PostsList from '../components/PostsList'

const blogCategoryTemplate = ({ data, location }) => {
  const { posts, categories } = data
  const title = `Blog`
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

export default blogCategoryTemplate

export const blogCategoryQuery = graphql`
  query($title: String!) {
    posts: allMarkdownRemark(
      sort: { fields: [frontmatter___date], order: DESC }
      filter: { frontmatter: { categories: { in: [$title] } } }
    ) {
      edges {
        node {
          ...postFields
        }
      }
    }
    ...categories
  }
`
