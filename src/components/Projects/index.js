import React, { useState, Fragment } from 'react'

import { Project, Img, Meta, Date, Tech, GitHub, Homepage } from './styles'
import Grid from '../styles/Grid'
import Modal from '../Modal'

const Projects = ({ projects }) => {
  const [modal, setModal] = useState()
  return (
    <Grid min="15em" gap="1em">
      {projects.map(({ node }, index) => {
        const { title, cover, date, url, repo, tech } = node.frontmatter
        return (
          <Fragment key={title}>
            <Project onClick={() => setModal(index)}>
              <Img fluid={cover.img.fluid} />
              <h3>{title}</h3>
            </Project>
            <Modal open={index === modal} closeModal={setModal}>
              <h2>
                <a href={url}>{title}</a>
              </h2>
              <Img fluid={cover.img.fluid} />
              <Meta>
                <Homepage />
                <a href={url}>{url.split(`//`).pop()}</a>
                {date && (
                  <>
                    <Date />
                    {date}
                  </>
                )}
                {repo && (
                  <a href={repo}>
                    <GitHub />
                    Repo
                  </a>
                )}
                <br />
                {tech && (
                  <>
                    <Tech />
                    {tech.map((name, index) => (
                      <Fragment key={name}>
                        {!!index && `, `}
                        <span>{name}</span>
                      </Fragment>
                    ))}
                  </>
                )}
              </Meta>
              <p dangerouslySetInnerHTML={{ __html: node.html }} />
            </Modal>
          </Fragment>
        )
      })}
    </Grid>
  )
}

export default Projects
