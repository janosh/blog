import React, { Component, createRef } from "react"
import { DownArrow } from "styled-icons/boxicons-regular/DownArrow"

import { NavContainer, NavEntry, SubNav, NavLink, Toggle } from "./styles"

const events = [
  { event: `mousedown`, handler: `handleClickOutside` },
  { event: `touchstart`, handler: `handleClickOutside` },
  { event: `scroll`, handler: `handleScroll` },
]

export default class Nav extends Component {
  state = {
    showNav: false,
    ref: createRef(),
    showSubNav: false,
  }

  toggleNav = () => {
    this.setState({ showNav: !this.state.showNav, showSubNav: false })
  }

  toggleSubNav = index => () => {
    const { showSubNav } = this.state
    this.setState({ showSubNav: index === showSubNav ? false : index })
  }

  handleClickOutside = event => {
    const { ref, showNav } = this.state
    if (!ref.current.contains(event.target) && showNav) {
      this.toggleNav()
    }
  }

  handleScroll = () => {
    if (this.state.showNav) {
      this.toggleNav()
    }
  }

  componentDidMount() {
    events.forEach(({ event, handler }) =>
      document.addEventListener(event, this[handler])
    )
  }

  componentWillUnmount() {
    events.forEach(({ event, handler }) =>
      document.removeEventListener(event, this[handler])
    )
  }

  render() {
    const { showNav, ref, showSubNav } = this.state
    return (
      <>
        <Toggle onClick={this.toggleNav} asMenu />
        <NavContainer role="navigation" ref={ref} showNav={showNav}>
          <Toggle onClick={this.toggleNav} />
          {this.props.nav.map(({ url, title, subNav }, index) => (
            <NavEntry key={url}>
              <NavLink
                to={url || subNav[0].url}
                as={subNav && showNav && showSubNav !== index && `span`}
                title={title}
                onClick={showNav ? this.toggleSubNav(index) : null}
              >
                {title} {subNav && <DownArrow size="0.5em" />}
              </NavLink>
              {subNav && (
                <SubNav showNav={showNav && showSubNav === index}>
                  <Toggle subNav onClick={this.toggleSubNav(index)} />
                  {subNav.map(item => (
                    <NavLink
                      key={item.url}
                      to={url + item.url}
                      title={item.title}
                      onClick={this.toggleNav}
                    >
                      {item.title}
                    </NavLink>
                  ))}
                </SubNav>
              )}
            </NavEntry>
          ))}
        </NavContainer>
      </>
    )
  }
}
