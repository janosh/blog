import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Dots from '../Dots'
import { SlideContainer, Slide } from './styles'

export default class Slideshow extends Component {
  static propTypes = {
    children: PropTypes.array.isRequired,
    delay: PropTypes.number.isRequired,
  }

  static defaultProps = {
    delay: 6.5,
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
    const dotProps = { current, n: children.length, onClick: this.jumpTo }
    return (
      <SlideContainer>
        {children.map((child, index) => (
          <Slide active={index === current} key={index} delay={delay}>
            {child}
          </Slide>
        ))}
        <Dots {...dotProps} position="bottom" />
      </SlideContainer>
    )
  }
}
