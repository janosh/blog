import React, { useState } from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import { PageBody } from "../components/styles"
import TagList from "../components/TagList"
import PostList from "../views/PostList"
import { paramCase, titleCase } from "../utils/misc"

const insertAllTag = (tags, count) => {
  if (!tags.group.map(tag => tag.title).includes(`All`))
    tags.group.unshift({ title: `All`, count })
}

const filterPostsByTag = (tag, posts) =>
  tag === `All`
    ? posts
    : posts.filter(({ node }) => node.frontmatter.tags.includes(tag))

const readActiveTagFromUrl = urlParams =>
  titleCase(urlParams.replace(/.*tag=([^&]+).*/, `$1`))

const BlogPage = ({ data, location }) => {
  const { posts, tags, img } = data
  const urlTag = readActiveTagFromUrl(location.search)
  const [tag, setTag] = useState(urlTag || `All`)
  const filteredPosts = filterPostsByTag(tag, posts.edges)
  insertAllTag(tags, posts.edges.length)

  const handleTagClick = tag => {
    setTag(tag)
    history.replaceState(
      { activeTag: tag },
      `active tag: ${tag}`,
      tag === `All` ? `/blog` : `/blog?tag=${paramCase(tag)}`
    )
  }

  return (
    <Global pageTitle="Blog" path={location.pathname}>
      <PageTitle img={img && img.sharp}>
        <h1>Blog</h1>
      </PageTitle>
      <PageBody>
        <TagList tags={tags.group} activeTag={tag} setTag={handleTagClick} />
        <PostList inBlog posts={filteredPosts} />
      </PageBody>
    </Global>
  )
}

export default BlogPage

export const query = graphql`
  {
    posts: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      edges {
        node {
          ...post
        }
      }
    }
    tags: allMarkdownRemark {
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
