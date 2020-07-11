import { graphql, useStaticQuery } from 'gatsby'
import Img from 'gatsby-image'
import React, { useState } from 'react'
import Project from './Project'
import { Modal, ProjectGrid, Thumbnail } from './styles'
import { useQueryParam } from 'hooks'

export function ProjectList(props) {
  const { allMdx } = useStaticQuery(graphql`
    {
      allMdx(
        filter: { fileAbsolutePath: { regex: "/pages/web/projects/" } }
        sort: { fields: frontmatter___date, order: DESC }
      ) {
        projects: nodes {
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
  `)
  const { projects } = allMdx

  const [urlProject, setUrlProject] = useQueryParam(`project`)
  const urlProjIdx = projects
    .map(p => p.frontmatter.title)
    .findIndex(title => title === urlProject)

  const [modal, setModal] = useState(urlProjIdx)

  const project = modal >= 0 && modal < projects.length && projects[modal]

  const setter = idx => {
    setUrlProject(projects[idx]?.frontmatter.title || null)
    setModal(idx)
  }
  return (
    <ProjectGrid minWidth="15em" gap="1em" {...props}>
      {projects.map(({ frontmatter: { title, cover } }, index) => (
        <Thumbnail key={title} onClick={() => setter(index)}>
          <Img {...cover?.img.sharp} />
          <h3>{title}</h3>
        </Thumbnail>
      ))}
      <Modal open={project} modal={modal} setModal={setter}>
        <Project {...project.frontmatter} body={project.body} />
      </Modal>
    </ProjectGrid>
  )
}
