import React from "react"
import { graphql } from "gatsby"

import Global from "../components/Global"
import PageTitle from "../components/PageTitle"
import { PageBody, Grid } from "../components/styles"
import Projects from "../views/Projects"

const WebPage = ({ data, location }) => {
  const { intro, projects, techLogos, techNames } = data
  const { title, cover } = intro.frontmatter
  return (
    <Global title={title} path={location.pathname}>
      <PageTitle img={cover && cover.img && cover.img.sharp}>
        <h1>{title}</h1>
      </PageTitle>
      <PageBody>
        <div dangerouslySetInnerHTML={{ __html: intro.html }} />
        <h2>Recent Projects</h2>
        <Projects {...projects} />
        <h2>My Stack</h2>
        <Grid minWidth="4.5em" align="center">
          {techNames.edges.map(({ node }) => (
            <a key={node.title} href={node.url}>
              <span>{node.title}</span>
              <img
                src={
                  techLogos.edges.find(
                    ({ node: logo }) => logo.name === node.file
                  ).node.src
                }
                alt={node.title}
              />
            </a>
          ))}
        </Grid>
      </PageBody>
    </Global>
  )
}

export default WebPage

export const query = graphql`
  {
    intro: markdownRemark(frontmatter: { purpose: { eq: "web intro" } }) {
      frontmatter {
        title
        ...cover
      }
      html
    }
    ...projects
    techLogos: allFile(
      filter: { relativeDirectory: { eq: "pages/web/techLogos" } }
    ) {
      edges {
        node {
          name
          src: publicURL
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
