import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Dots from '../Dots'
import { SlideContainer, Slide } from './styles'

const dotCss = `
  position: absolute;
  left: 50%;
  transform: translate(-50%);
  bottom: 1em;
`

export default class Slideshow extends Component {
  static propTypes = {
    children: PropTypes.array.isRequired,
    delay: PropTypes.number.isRequired,
  }

  static defaultProps = {
    delay: 4,
  }

  state = { current: 0 }

  next = () => {
    this.setState({
      current: (this.state.current + 1) % this.props.children.length,
    })
  }

  jumpTo = index => {
    clearInterval(this.interval)
    this.interval = setInterval(() => this.next(), this.props.delay * 1000)
    this.setState({
      current: index,
    })
  }

  componentDidMount() {
    this.interval = setInterval(this.next, this.props.delay * 1000)
  }

  componentWillUnmount() {
    clearInterval(this.interval)
  }

  render() {
    const { current } = this.state
    const { children, delay } = this.props
    return (
      <SlideContainer>
        {children.map((child, index) => (
          <Slide active={index === current} key={index} delay={delay}>
            {child}
          </Slide>
        ))}
        <Dots
          n={children.length}
          current={current}
          onClick={this.jumpTo}
          css={dotCss}
        />
      </SlideContainer>
    )
  }
}
