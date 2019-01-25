import React, { Fragment } from 'react'

import { Img, Meta, Date, Tech, GitHub, Homepage } from './styles'

const Project = ({ title, cover, date, url, repo, tech, html }) => (
  <>
    <h2>
      <a href={url}>{title}</a>
    </h2>
    <Img fluid={cover.img.sharp.fluid} />
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
    <p dangerouslySetInnerHTML={{ __html: html }} />
  </>
)

export default Project
