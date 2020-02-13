import { graphql, useStaticQuery } from 'gatsby'
import Img from 'gatsby-image'
import React, { useState } from 'react'
import Project from './Project'
import { Modal, ProjectGrid, Thumbnail } from './styles'

export function ProjectList(props) {
  let { projects } = useStaticQuery(graphql`
    {
      projects: allMdx(
        filter: { fileAbsolutePath: { regex: "/pages/web/projects/" } }
        sort: { fields: frontmatter___date, order: DESC }
      ) {
        edges {
          node {
            body
            frontmatter {
              title
              slug
              date(formatString: "MMM D, YYYY")
              url
              repo
              npm
              tech
              ...cover
            }
          }
        }
      }
    }
  `)
  projects = projects.edges.map(proj => proj.node)
  const [modal, setModal] = useState()
  const project = modal >= 0 && modal < projects.length && projects[modal]
  return (
    <ProjectGrid minWidth="15em" gap="1em" {...props}>
      {projects.map(({ frontmatter: { title, cover } }, index) => (
        <Thumbnail key={title} onClick={() => setModal(index)}>
          <Img {...cover?.img.sharp} />
          <h3>{title}</h3>
        </Thumbnail>
      ))}
      <Modal open={project} {...{ modal, setModal }}>
        <Project {...project.frontmatter} body={project.body} />
      </Modal>
    </ProjectGrid>
  )
}
