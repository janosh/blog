import React from 'react'
import { graphql, Link } from 'gatsby'
import PropTypes from 'prop-types'

import Global from '../components/Global'
import Particles from '../components/Particles'
import Grid from '../components/styles/Grid'

const Physics = ({ location, data: { page } }) => {
  const pageTitle = `Physics`
  const path = location.pathname
  const { description, lectures, outreach } = page
  return (
    <Global pageTitle={pageTitle} path={path} description={description}>
      <h1>{pageTitle}</h1>
      <p>{description}</p>
      <Particles />
      <Grid>
        {lectures.map(lecture => (
          <div key={lecture.title}>
            <Link to={`physics/` + lecture.slug}>{lecture.title}</Link>
          </div>
        ))}
      </Grid>
      <p dangerouslySetInnerHTML={{ __html: outreach }} />
    </Global>
  )
}

export default Physics

export const query = graphql`
  {
    page: physicsYaml {
      description
      lectures {
        title
        slug
      }
      outreach
    }
  }
`

Physics.propTypes = {
  location: PropTypes.shape({
    pathname: PropTypes.string.isRequired,
  }).isRequired,
  data: PropTypes.shape({
    page: PropTypes.shape({
      description: PropTypes.string.isRequired,
      lectures: PropTypes.arrayOf(
        PropTypes.shape({
          title: PropTypes.string.isRequired,
          slug: PropTypes.string.isRequired,
        })
      ).isRequired,
      outreach: PropTypes.string.isRequired,
    }),
  }),
}
