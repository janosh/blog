import React, { Component } from "react"
import PropTypes from "prop-types"

import { Arrow } from "./styles"

export default class Scroll extends Component {
  static propTypes = {
    direction: PropTypes.string,
    to: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
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
    const { direction, to, by } = this.props
    const sign = direction === `top` ? 1 : -1
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
      window.addEventListener(`scroll`, this.handleScroll)
  }

  componentWillUnmount() {
    window.removeEventListener(`scroll`, this.handleScroll)
  }

  render() {
    const { to, direction = { top: `up`, bottom: `down` }[to] } = this.props
    return (
      <Arrow
        onClick={this.handleClick}
        direction={direction}
        {...this.props}
        {...this.state}
      />
    )
  }
}
