import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { StaticQuery, graphql } from 'gatsby'

import Dots from '../Dots'
import { AboutContainer, Text, Arrow } from './styles'

class About extends Component {
  static propTypes = {
    html: PropTypes.string.isRequired,
  }

  state = { current: 0, about: this.props.html.split(`\n`) }

  jumpTo = index => {
    this.setState({
      current: index,
    })
  }

  next = () => {
    this.setState({
      current: (this.state.current + 1) % this.state.about.length,
    })
  }

  render() {
    const { current, about } = this.state
    const dotProps = { current, n: about.length, onClick: this.jumpTo }
    return (
      <AboutContainer>
        <Dots {...dotProps} size="0.5em" />
        <Text dangerouslySetInnerHTML={{ __html: about[current] }} />
        <Arrow size="4em" onClick={this.next} />
      </AboutContainer>
    )
  }
}

const query = graphql`
  {
    about: markdownRemark(frontmatter: { purpose: { eq: "about" } }) {
      html
    }
  }
`

export default props => (
  <StaticQuery
    query={query}
    render={data => <About {...data.about} {...props} />}
  />
)
