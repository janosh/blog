import React, { Component } from 'react'
import PropTypes from 'prop-types'

import { Arrows } from './styles'

export default class Scroll extends Component {
  static propTypes = {
    dir: PropTypes.string,
    to: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
    by: PropTypes.number,
    size: PropTypes.string,
  }

  static defaultProps = {
    size: `1.7em`,
  }

  state = { show: this.props.showBelow ? false : true }

  scroll = ({ mode, to }) =>
    window[`scroll` + mode]({ top: to, behavior: `smooth` })

  handleClick = () => {
    const { dir, to, by } = this.props
    const sign = dir === `top` ? 1 : -1
    if (to === `top`) this.scroll({ mode: `To`, to: 0 })
    else if (to === `bottom`)
      this.scroll({ mode: `To`, to: document.body.scrollHeight })
    else if (to) this.scroll({ mode: `To`, to: to * window.innerHeight })
    else this.scroll({ mode: `By`, to: sign * by * window.innerHeight })
  }

  handleScroll = () => {
    if (window.pageYOffset > this.props.showBelow) {
      if (!this.state.show) this.setState({ show: true })
    } else {
      if (this.state.show) this.setState({ show: false })
    }
  }

  componentDidMount() {
    if (this.props.showBelow)
      window.addEventListener('scroll', this.handleScroll)
  }

  componentWillUnmount() {
    window.removeEventListener('scroll', this.handleScroll)
  }

  render() {
    let { dir, to } = this.props
    if (!dir) {
      if (to === `top`) dir = `up`
      else if (to === `bottom`) dir = `down`
    }
    const Arrow = Arrows[dir]
    return <Arrow onClick={this.handleClick} {...this.props} {...this.state} />
  }
}
