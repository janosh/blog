import React, { useState } from 'react'
import Modal from 'components/Modal'
import Project from './Project'
import { Img, ProjectGrid, Thumbnail } from './styles'

const Projects = ({ projects, ...rest }) => {
  const [modal, setModal] = useState()
  const project = modal >= 0 && modal < projects.length && projects[modal].node
  return (
    <ProjectGrid minWidth="15em" gap="1em" {...rest}>
      {projects.map(({ node }, index) => {
        const { title, cover } = node.frontmatter
        return (
          <Thumbnail key={title} onClick={() => setModal(index)}>
            {cover && <Img fluid={cover.img.sharp.fluid} />}
            <h3>{title}</h3>
          </Thumbnail>
        )
      })}
      <Modal
        open={project}
        {...{ modal, setModal }}
        css="padding: 2em; max-width: 40em;"
      >
        <Project {...project.frontmatter} body={project.body} />
      </Modal>
    </ProjectGrid>
  )
}

export default Projects
