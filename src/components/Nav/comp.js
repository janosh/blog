import React, { Component, Fragment } from 'react'
import PropTypes from 'prop-types'

import { Container, NavLink, Toggle } from './styles'

const events = ['mousedown', 'touchstart']

export default class Nav extends Component {
  static propTypes = {
    nav: PropTypes.arrayOf(
      PropTypes.shape({
        node: PropTypes.shape({
          title: PropTypes.string.isRequired,
          slug: PropTypes.string.isRequired,
        }),
      })
    ),
  }
  state = { showNav: false }

  toggleNav = () => {
    this.setState({ showNav: !this.state.showNav })
  }

  handleClickOutside = event => {
    if (this.node && !this.node.contains(event.target) && this.state.showNav) {
      this.toggleNav()
    }
  }

  handleScroll = () => {
    if (this.state.showNav) {
      this.toggleNav()
    }
  }

  componentDidMount() {
    events.forEach(event =>
      document.addEventListener(event, this.handleClickOutside)
    )
    document.addEventListener(`scroll`, this.handleScroll)
  }

  componentWillUnmount() {
    events.forEach(event =>
      document.removeEventListener(event, this.handleClickOutside)
    )
  }

  render() {
    return (
      <Fragment>
        <Toggle onClick={this.toggleNav}>&#9776;</Toggle>
        <Container
          role="navigation"
          ref={node => (this.node = node)}
          showNav={this.state.showNav}
        >
          <Toggle inside onClick={this.toggleNav}>
            &times;
          </Toggle>
          {this.props.nav.map(item => (
            <NavLink
              key={item.slug}
              activeClassName="active"
              to={item.slug}
              title={item.title}
              onClick={this.toggleNav}
            >
              {item.title}
            </NavLink>
          ))}
        </Container>
      </Fragment>
    )
  }
}
