import { graphql } from 'gatsby'
import { MDXRenderer } from 'gatsby-plugin-mdx'
import React from 'react'
import Global from 'components/Global'
import PageTitle from 'components/PageTitle'
import { Grid, PageBody } from 'components/styles'
import Projects from 'views/Projects'

const techLinkCss = `transition: 0.4s; :hover {transform: scale(1.05);}`

export default function WebPage({ data, location }) {
  const { mdx, projects, tech } = data
  const { title, cover } = mdx.frontmatter
  return (
    <Global title={title} path={location.pathname}>
      <PageTitle img={cover && cover.img && cover.img.sharp}>
        <h1>{title}</h1>
      </PageTitle>
      <PageBody>
        <MDXRenderer>{mdx.body}</MDXRenderer>
        <h2>Recent Projects</h2>
        <Projects {...projects} />
        <h2>My Stack</h2>
        <Grid minWidth="5em" align="center">
          {tech.edges.map(({ node: { title, url, logo } }) => (
            <a key={title} href={url} css={techLinkCss}>
              <span css="font-size: 0.85em;">{title}</span>
              <img src={logo.src} alt={title} />
            </a>
          ))}
        </Grid>
      </PageBody>
    </Global>
  )
}

export const query = graphql`
  {
    mdx(frontmatter: { purpose: { eq: "web intro" } }) {
      frontmatter {
        title
        ...cover
      }
      body
    }
    ...projects
    tech: allTechYaml {
      edges {
        node {
          title
          url
          logo {
            src: publicURL
          }
        }
      }
    }
  }
`
