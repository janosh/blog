import React from 'react'
import styled, { css } from 'styled-components'
import { Link } from 'gatsby'
import { Close } from 'styled-icons/material/Close'
import { Menu } from 'styled-icons/feather/Menu'

import mediaQuery from '../../utils/mediaQuery'

const partlyActive = className => ({ isPartiallyCurrent }) =>
  isPartiallyCurrent ? { className: className + ' active' } : null

const PartlyActiveLink = props => (
  <Link getProps={partlyActive(props.className)} {...props} />
)

export const navLinkStyle = css`
  color: ${props => props.theme.mainWhite};
  transition: ${props => props.theme.shortTrans};
  cursor: pointer;
  &.active {
    color: ${props => props.theme.mainOrange};
  }
  :hover {
    color: ${props => props.theme.lightBlue};
  }
`

export const NavContainer = styled.nav`
  grid-area: nav;
  display: grid;
  grid-gap: 2vw;
  ${mediaQuery.maxPhablet} {
    overflow-y: scroll;
    position: fixed;
    right: 100%;
    z-index: 2;
    background: ${props => props.theme.darkGray};
    padding: 5vh;
    grid-gap: 1em;
    height: 100vh;
    min-width: 15vw;
    grid-auto-columns: minmax(max-content, 1fr);
    grid-auto-rows: max-content;
    transform: translate(${props => (props.showNav ? `99%` : `0`)});
    transition: ${props => props.theme.mediumTrans};
  }
  ${mediaQuery.minPhablet} {
    grid-auto-flow: column;
    grid-auto-columns: max-content;
    justify-self: start;
  }
`

export const NavEntry = styled.div`
  position: relative;
`

const subNavVisible = css`
  opacity: 1;
  pointer-events: initial;
  background: ${props => props.theme.mainGray};
  position: static;
`

export const SubNav = styled.div`
  display: grid;
  width: max-content;
  border-radius: ${props => props.theme.smallBorderRadius};
  grid-gap: 0.2em 0.5em;
  opacity: 0;
  position: absolute;
  transition: all 0.4s;
  padding: 0.5em 0.7em;
  grid-template-columns: ${props =>
    props.children[1].length >= 10 ? `1fr 1fr` : `1fr`};
  pointer-events: none;
  ${mediaQuery.maxNetbook} {
    ${props => props.showNav && subNavVisible};
  }
  ${mediaQuery.minNetbook} {
    ${NavEntry}:hover & {
      ${subNavVisible};
      position: absolute;
    }
  }
`

const span = css`
  grid-column: 1/-1;
  border-top: 1px solid ${props => props.theme.mainWhite};
  padding-top: 0.2em;
`

export const NavLink = styled(PartlyActiveLink)`
  ${navLinkStyle};
  ${SubNav} & {
    color: ${props => props.theme.mainWhite};
    :hover {
      color: ${props => props.theme.lightGreen};
    }
    &.active {
      color: ${props => props.theme.lightBlue};
    }
    ${props => props.span && span};
  }
`

const subNavToggle = css`
  border-radius: 30% 30% 0 0;
  background: ${props => props.theme.mainGray};
`

const inNavToggle = css`
  position: absolute;
  top: ${props => (props.subNav ? `0` : `0.3em`)};
  right: ${props => (props.subNav ? `0` : `0.5em`)};
  ${props => props.subNav && subNavToggle}
`

const inHeaderToggle = css`
  grid-area: 1 / 1 / 1 / 1;
`

export const Toggle = styled(Close).attrs(props => ({
  size: `1.7em`,
  as: props.asMenu && Menu,
}))`
  cursor: pointer;
  ${props => (props.asMenu ? inHeaderToggle : inNavToggle)};
  ${navLinkStyle};
  ${mediaQuery.minPhablet} {
    display: none;
  }
`
