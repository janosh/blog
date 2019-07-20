import React, { Fragment } from 'react'
import { Date, GitHub, Homepage, Img, Meta, NPM, Tech } from './styles'

const Project = ({ title, cover, date, url, repo, npm, tech, html }) => (
  <>
    <h2>
      <a href={url}>{title}</a>
    </h2>
    {cover && <Img fluid={cover.img.sharp.fluid} />}
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
      {npm && (
        <a href={npm}>
          <NPM />
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
