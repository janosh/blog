import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import Grid from '../components/styles/Grid'
import Project from '../components/styles/Project'

const Web = ({ data, location }) => {
  const title = `Web`
  const { intro, projects, techLogos, techNames } = data
  return (
    <Global title={title} path={location.pathname}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <div dangerouslySetInnerHTML={{ __html: intro.html }} />
      <h2>Recent Projects</h2>
      <Grid min="15em">
        {projects.edges.map(({ node }) => (
          <Project
            key={node.id}
            dangerouslySetInnerHTML={{ __html: node.html }}
          />
        ))}
      </Grid>
      <h2>Technologies I like to use</h2>
      <Grid min="4em" align="center">
        {techNames.edges.map(({ node }) => (
          <a key={node.title} href={node.url}>
            <span>{node.title}</span>
            <img
              src={
                techLogos.edges.find(
                  ({ node: logo }) => logo.name === node.file
                ).node.publicURL
              }
              alt={node.title}
            />
          </a>
        ))}
      </Grid>
    </Global>
  )
}

export default Web

export const query = graphql`
  {
    intro: markdownRemark(frontmatter: { purpose: { eq: "web intro" } }) {
      html
    }
    projects: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/pages/web/projects/" } }
    ) {
      edges {
        node {
          id
          html
        }
      }
    }
    techLogos: allFile(
      filter: { relativeDirectory: { eq: "pages/web/techLogos" } }
    ) {
      edges {
        node {
          name
          publicURL
        }
      }
    }
    techNames: allTechYaml {
      edges {
        node {
          title
          url
          file
        }
      }
    }
  }
`
