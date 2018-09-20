import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { StaticQuery, graphql } from 'gatsby'

import { AboutContainer, Next } from './styles'

class About extends Component {
  static propTypes = {
    about: PropTypes.array.isRequired,
  }

  state = { current: 0 }

  next = () => {
    this.setState({
      current: (this.state.current + 1) % this.props.about.length,
    })
  }

  render() {
    const { current } = this.state
    const { about } = this.props
    return (
      <AboutContainer>
        <p>
          <span>
            {current + 1}/{about.length}
          </span>
          <Next onClick={this.next}>I</Next>
          <span
            dangerouslySetInnerHTML={{ __html: about[current].node.text }}
          />
        </p>
      </AboutContainer>
    )
  }
}

const query = graphql`
  {
    about: allAboutYaml {
      edges {
        node {
          text
        }
      }
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <About about={data.about.edges} />}
  />
)
