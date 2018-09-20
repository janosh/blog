import React from 'react'
import { graphql } from 'gatsby'

import Global from '../components/Global'
import Section from '../components/styles/Section'
import Grid from '../components/styles/Grid'

const Web = ({ data, location }) => {
  const { techLogos, techNames } = data
  const techs = techNames.edges.map(({ node: tech }) => {
    return {
      ...tech,
      src: techLogos.edges.find(({ node }) => node.name === tech.file).node
        .publicURL,
    }
  })
  return (
    <Global path={location.pathname}>
      <Section>
        <h1>Recent Projects</h1>
        Things I've worked on recently
      </Section>
      <Section>
        <h1>My Stack</h1>
        <h2>Technologies I enjoy using:</h2>
        <Grid min="4em">
          {techs.map(tech => (
            <a key={tech.title} href={tech.url}>
              <p>{tech.title}</p>
              <img src={tech.src} alt={tech.title} />
            </a>
          ))}
        </Grid>
      </Section>
    </Global>
  )
}

export default Web

export const query = graphql`
  {
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
