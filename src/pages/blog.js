import { graphql } from 'gatsby'
import { kebabCase } from 'lodash'
import React from 'react'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import { PageBody } from 'components/styles'
import TagList from 'components/TagList'
import { useQueryParam } from 'hooks'
import PostList from 'views/PostList'

const addSlugs = tags =>
  tags.map(tag => ({
    slug: kebabCase(tag.title),
    ...tag,
  }))

const insertAllTag = (tags, count) =>
  !tags.map(tag => tag.title).includes(`All`)
    ? [{ title: `All`, slug: null, count }, ...addSlugs(tags)]
    : tags

const filterPostsByTag = (tag, posts) =>
  tag && tag.slug
    ? posts.filter(({ node }) => node.frontmatter.tags.includes(tag.title))
    : posts

export default function BlogPage({ data, location }) {
  const { posts, tags, img } = data
  const [activeTag, setActiveTag] = useQueryParam(`tag`)
  const allTags = insertAllTag(tags.group, posts.edges.length)
  const filteredPosts = filterPostsByTag(
    allTags.find(tag => tag.slug === activeTag),
    posts.edges
  )
  return (
    <Global pageTitle="Blog" path={location.pathname}>
      <PageTitle img={img && img.sharp}>
        <h1>Blog</h1>
      </PageTitle>
      <PageBody>
        <TagList {...{ tags: allTags, activeTag, setActiveTag }} />
        <PostList inBlog posts={filteredPosts} />
      </PageBody>
    </Global>
  )
}

export const query = graphql`
  {
    posts: allMdx(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      edges {
        node {
          ...post
        }
      }
    }
    tags: allMdx {
      group(field: frontmatter___tags) {
        title: fieldValue
        count: totalCount
      }
    }
    img: file(name: { eq: "blog-cover" }) {
      sharp: childImageSharp {
        fluid(maxWidth: 1800) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
