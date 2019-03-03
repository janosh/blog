import React, { useState, Fragment } from "react"

import { ProjectGrid, Thumbnail, Img } from "./styles"
import Project from "./Project"
import Modal from "../../components/Modal"

const Projects = ({ projects, ...rest }) => {
  const [modal, setModal] = useState()
  return (
    <ProjectGrid minWidth="15em" gap="1em" {...rest}>
      {projects.map(({ node }, index) => {
        const { title, cover } = node.frontmatter
        return (
          <Fragment key={title}>
            <Thumbnail onClick={() => setModal(index)}>
              {cover && <Img fluid={cover.img.sharp.fluid} />}
              <h3>{title}</h3>
            </Thumbnail>
            <Modal open={index === modal} setModal={setModal}>
              <Project {...node.frontmatter} html={node.html} />
            </Modal>
          </Fragment>
        )
      })}
    </ProjectGrid>
  )
}

export default Projects
