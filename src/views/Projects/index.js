import React, { useState } from "react"

import { ProjectGrid, Thumbnail, Img } from "./styles"
import Project from "./Project"
import Modal from "../../components/Modal"

const Projects = ({ projects, ...rest }) => {
  const [modal, setModal] = useState()
  const project = modal >= 0 && projects[modal].node
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
      {project && (
        <Modal open={project} setModal={setModal} css="padding: 2em;">
          <Project {...project.frontmatter} html={project.html} />
        </Modal>
      )}
    </ProjectGrid>
  )
}

export default Projects
