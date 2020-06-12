import React from 'react'
import { graphql, useStaticQuery } from 'gatsby'
import { Grid } from 'components/styles'

export function TechStack() {
  const { tech } = useStaticQuery(graphql`
    {
      tech: allTechYaml {
        nodes {
          title
          url
          logo {
            src: publicURL
          }
        }
      }
    }
  `)
  return (
    <Grid minWidth="5em" align="center">
      {tech.nodes.map(({ title, url, logo }) => (
        <a
          key={title}
          href={url}
          css="transition: 0.4s; :hover {transform: scale(1.05);}"
        >
          <span css="font-size: 0.85em;">{title}</span>
          <img src={logo.src} alt={title} />
        </a>
      ))}
    </Grid>
  )
}
