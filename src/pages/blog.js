import React, { useState } from "react"
import { graphql, navigate } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import PageBody from "../components/styles/PageBody"
import TagList from "../components/TagList"
import PostList from "../views/PostList"
import { paramCase, titleCase } from "../utils/case"

const BlogPage = ({ data, location }) => {
  const { posts, tags, img } = data
  const urlTag = titleCase(location.search.replace(/.*tag=([^&]+).*/, `$1`))
  const [tag, setTag] = useState(urlTag || `All`)
  const filteredPosts =
    tag === `All`
      ? posts.edges
      : posts.edges.filter(({ node }) => node.frontmatter.tags.includes(tag))
  if (!tags.group.map(tag => tag.title).includes(`All`))
    tags.group.unshift({ title: `All`, count: posts.edges.length })
  const handleTagClick = tag => {
    setTag(tag)
    navigate(tag === `All` ? `/blog` : `/blog?tag=${paramCase(tag)}`)
  }
  return (
    <Global pageTitle="Blog" path={location.pathname}>
      <PageTitle img={img && img.sharp}>
        <h1>Blog</h1>
      </PageTitle>
      <PageBody cols="2/-2">
        <TagList tags={tags.group} activeTag={tag} setTag={handleTagClick} />
        <PostList posts={filteredPosts} />
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
        fluid(quality: 100, maxWidth: 2000) {
          ...GatsbyImageSharpFluid_withWebp
        }
      }
    }
  }
`
