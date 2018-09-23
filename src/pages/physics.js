import React from 'react'
import { graphql, Link } from 'gatsby'
import Img from 'gatsby-image'

import Global from '../components/Global'
import PageTitle from '../components/PageTitle'
import Grid from '../components/styles/Grid'

const Physics = ({ location, data: { intro, physics, images } }) => {
  const pageTitle = `Physics`
  return (
    <Global
      pageTitle={pageTitle}
      path={location.pathname}
      description={intro.excerpt}
    >
      <PageTitle>
        <h1>{pageTitle}</h1>
      </PageTitle>
      <div dangerouslySetInnerHTML={{ __html: intro.html }} />
      <Grid min="8em" align="center">
        {physics.lectures.map(lecture => (
          <Link key={lecture.title} to={`physics/` + lecture.slug}>
            {lecture.title}
            <Img
              fluid={
                images.edges.find(({ node }) => node.name === lecture.file).node
                  .img.fluid
              }
            />
          </Link>
        ))}
      </Grid>
    </Global>
  )
}

export default Physics

export const query = graphql`
  {
    intro: markdownRemark(frontmatter: { purpose: { eq: "physics intro" } }) {
      html
      excerpt
    }
    physics: physicsYaml {
      lectures {
        title
        slug
        file
      }
    }
    images: allFile(
      filter: { relativeDirectory: { eq: "pages/physics/images" } }
    ) {
      edges {
        node {
          name
          img: childImageSharp {
            fluid(maxWidth: 500, quality: 100) {
              ...GatsbyImageSharpFluid_withWebp
            }
          }
        }
      }
    }
  }
`
