import { graphql, Link } from 'gatsby'
import Img from 'gatsby-image'
import { MDXRenderer } from 'gatsby-plugin-mdx'
import React from 'react'
import styled, { css } from 'styled-components'
import { ArrowLeft } from 'styled-icons/fa-solid/ArrowLeft'
import { ArrowRight } from 'styled-icons/fa-solid/ArrowRight'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import Scroll from 'components/Scroll'
import { PageBody } from 'components/styles'
import mediaQuery from 'utils/mediaQuery'
import PostList from 'views/PostList'
import { ProjectList } from 'views/Web'

export default function IndexPage({ data, location }) {
  const { mdx, janosh, posts } = data
  const img = {
    ...mdx.frontmatter.cover,
    fluid: mdx.frontmatter.cover.img.sharp.fluid,
  }
  return (
    <Global path={location.pathname}>
      <PageTitle img={img} fillToBottom backdrop={false}>
        <Title>
          {mdx.frontmatter.title.split(`, `).map(str => (
            <Link key={str} to={`/` + str.toLowerCase()}>
              {str}
            </Link>
          ))}
        </Title>
        <Scroll direction="down" to={1} />
      </PageTitle>
      <PageBody>
        <Img
          fixed={janosh.img.fixed}
          css="border-radius: 50%; justify-self: center;"
        />
        <MDXRenderer>{mdx.body}</MDXRenderer>
        <H>Recent posts</H>
        <PostList asRow noText posts={posts.edges} />
        <H>Recent projects</H>
        <ProjectList asRow />
      </PageBody>
    </Global>
  )
}

const Title = styled.h1`
  border: 1px solid white;
  padding: 0.4em;
  background: rgba(0, 0, 0, 0.4);
  display: grid;
  a {
    padding: 0.4em;
    color: white;
    ${mediaQuery.maxPhone} {
      & + a {
        border-top: 0.5px solid rgba(255, 255, 255, 0.9);
      }
    }
  }
  ${mediaQuery.minPhone} {
    grid-template-columns: 1fr 1fr;
    a {
      :nth-child(2),
      :nth-child(3) {
        background: rgba(0, 0, 0, 0.6);
      }
    }
  }
`

const iconCss = css`
  width: 0.6em;
  vertical-align: 0;
  margin: 0 0.4em;
`

const H = ({ children, as }) => (
  <h1 as={as} css="text-align: center;">
    <ArrowLeft css={iconCss} />
    {children}
    <ArrowRight css={iconCss} />
  </h1>
)

export const query = graphql`
  {
    mdx(fileAbsolutePath: { regex: "/landing.md/" }) {
      frontmatter {
        title
        ...cover
      }
      body
    }
    janosh: file(name: { eq: "janosh" }) {
      img: childImageSharp {
        fixed(width: 175) {
          ...GatsbyImageSharpFixed_withWebp
        }
      }
    }
    posts: allMdx(
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
  }
`
