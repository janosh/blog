import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import Grid from "../components/styles/Grid"
import Projects from "../views/Projects"

const WebPage = ({ data, location }) => {
  const title = `Web`
  const { intro, projects, techLogos, techNames } = data
  return (
    <Global title={title} path={location.pathname}>
      <PageTitle>
        <h1>{title}</h1>
      </PageTitle>
      <div dangerouslySetInnerHTML={{ __html: intro.html }} />
      <h2>Recent Projects</h2>
      <Projects {...projects} />
      <h2>My Stack</h2>
      <Grid minWidth="4em" align="center">
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

export default WebPage

export const query = graphql`
  {
    intro: markdownRemark(frontmatter: { purpose: { eq: "web intro" } }) {
      html
    }
    projects: allMarkdownRemark(
      filter: { fileAbsolutePath: { regex: "/pages/web/projects/" } }
      sort: { fields: frontmatter___date, order: DESC }
    ) {
      projects: edges {
        node {
          html
          frontmatter {
            title
            slug
            date(formatString: "MMM DD, YYYY")
            url
            repo
            npm
            tech
            cover {
              img {
                sharp: childImageSharp {
                  fluid(maxWidth: 2500, quality: 100) {
                    ...GatsbyImageSharpFluid_withWebp
                  }
                }
              }
            }
          }
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
