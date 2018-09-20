import { MDXRenderer } from 'gatsby-plugin-mdx'
import React, { Fragment } from 'react'
import { Date, GitHub, Homepage, Meta, NPM, Tech } from './styles'
import Img from 'gatsby-image'

const Project = ({ title, cover, date, url, repo, npm, tech, body }) => (
  <>
    <h2 css="margin-top: 0;">
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
              {index > 0 && `, `}
              <span>{name}</span>
            </Fragment>
          ))}
        </>
      )}
    </Meta>
    <MDXRenderer>{body}</MDXRenderer>
  </>
)

export default Project
