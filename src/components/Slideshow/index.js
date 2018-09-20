import React, { Component } from 'react'
import PropTypes from 'prop-types'

import { SlideContainer, Slide, Dots, Dot } from './styles'

export default class Slideshow extends Component {
  static propTypes = {
    children: PropTypes.array.isRequired,
    delay: PropTypes.number.isRequired,
  }

  static defaultProps = {
    delay: 4,
  }

  state = { current: 0 }

  nextSlide = () => {
    this.setState({
      current: (this.state.current + 1) % this.props.children.length,
    })
  }

  setSlide = index => {
    clearInterval(this.interval)
    this.interval = setInterval(() => this.nextSlide(), this.props.delay * 1000)
    this.setState({
      current: index,
    })
  }

  componentDidMount() {
    this.interval = setInterval(this.nextSlide, this.props.delay * 1000)
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
        <Dots>
          {Array.apply(null, { length: children.length }).map((dot, index) => (
            <Dot
              key={index}
              active={index === current}
              onClick={() => this.setSlide(index)}
            />
          ))}
        </Dots>
      </SlideContainer>
    )
  }
}
