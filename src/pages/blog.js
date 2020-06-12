import PageTitle from 'components/PageTitle'
import { PageBody } from 'components/styles'
import TagList from 'components/TagList'
import { graphql } from 'gatsby'
import { useQueryParam } from 'hooks'
import React from 'react'
import PostList from 'views/PostList'

const insertAllTag = (tags, count) =>
  !tags.map(tag => tag.title).includes(`All`) &&
  tags.unshift({ title: `All`, count })

const filterPostsByTag = (tag, posts) =>
  // If !tag, tag is null which stands for all posts.
  posts.filter(post => !tag || post.frontmatter.tags.includes(tag))

export default function BlogPage({ data }) {
  const { allMdx, img } = data
  const { posts, tags } = allMdx
  const [activeTag, setActiveTag] = useQueryParam(`tag`)
  insertAllTag(tags, posts.length)
  const filteredPosts = filterPostsByTag(activeTag, posts)
  return (
    <>
      <PageTitle img={img}>
        <h1>Blog</h1>
      </PageTitle>
      <PageBody>
        <TagList {...{ tags, activeTag, setActiveTag }} />
        <PostList inBlog posts={filteredPosts} />
      </PageBody>
    </>
  )
}

export const query = graphql`
  {
    allMdx(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      posts: nodes {
        ...page
      }
      tags: group(field: frontmatter___tags) {
        title: fieldValue
        count: totalCount
      }
    }
    img: file(name: { eq: "blog-banner" }) {
      ...sharpSrc
    }
  }
`
