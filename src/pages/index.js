import React from "react"
import { graphql } from "gatsby"
import Img from "gatsby-image"
import styled from "styled-components"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import Scroll from "../components/Scroll"
import PageBody from "../components/styles/PageBody"
import PostList from "../views/PostList"
import Projects from "../views/Projects"
import mediaQuery from "../utils/mediaQuery"

const Title = styled.h1`
  border: 1px solid white;
  padding: 0.4em;
  background: rgba(0, 0, 0, 0.4);
  display: grid;
  span {
    padding: 0.4em;
    ${mediaQuery.maxPhone} {
      & + span {
        border-top: 0.5px solid rgba(255, 255, 255, 0.9);
      }
    }
  }
  ${mediaQuery.minPhone} {
    grid-template-columns: 1fr 1fr;
    span {
      :nth-child(2),
      :nth-child(3) {
        background: rgba(0, 0, 0, 0.6);
      }
    }
  }
`

const IndexPage = ({ data, location }) => {
  const { md, janosh, posts, projects } = data
  const img = {
    ...md.frontmatter.cover,
    fluid: md.frontmatter.cover.img.sharp.fluid,
  }
  return (
    <Global margin="0" transparent path={location.pathname}>
      <PageTitle img={img} fillToBottom>
        <Title>
          {md.frontmatter.title.split(`, `).map(str => (
            <span key={str}>{str}</span>
          ))}
        </Title>
        <Scroll direction="down" to={1} align="center" position="absolute" />
      </PageTitle>
      <PageBody>
        <Img
          fixed={janosh.img.fixed}
          css="border-radius: 50%; justify-self: center;"
        />
        <p dangerouslySetInnerHTML={{ __html: md.html }} />
        <h1 css="justify-self: center;">Recent posts</h1>
        <PostList
          posts={posts.edges}
          css="grid-column: 2/-2; grid-auto-flow: column; overflow: scroll;"
        />
        <h1 css="justify-self: center;">Recent projects</h1>
        <Projects
          {...projects}
          css="grid-column: 2/-2; grid-auto-flow: column; overflow: scroll;"
        />
      </PageBody>
    </Global>
  )
}

export default IndexPage

export const query = graphql`
  {
    md: markdownRemark(frontmatter: { purpose: { eq: "landing intro" } }) {
      frontmatter {
        title
        ...cover
      }
      html
    }
    janosh: file(name: { eq: "janosh" }) {
      img: childImageSharp {
        fixed(width: 175) {
          ...GatsbyImageSharpFixed_withWebp
        }
      }
    }
    posts: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/posts/" } }
      sort: { fields: frontmatter___date, order: DESC }
      limit: 5
    ) {
      edges {
        node {
          ...post
        }
      }
    }
    ...projects
  }
`
