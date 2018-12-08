import styled, { css } from 'styled-components'
import { Link } from 'gatsby'

import mediaQuery from '../../utils/mediaQuery'

export const navLinkStyle = css`
  color: ${props => props.theme.mainWhite};
  transition: ${props => props.theme.shortTrans};
  :hover {
    color: ${props => props.theme.lightBlue};
  }
  &.${props => props.activeClassName} {
    color: ${props => props.theme.mainOrange};
  }
`

export const NavContainer = styled.nav`
  display: grid;
  grid-gap: calc(0.4em + 2vw);
  grid-auto-columns: max-content;
  ${mediaQuery.maxPhablet} {
    overflow-x: scroll;
    position: fixed;
    right: 100%;
    z-index: 2;
    background: ${props => props.theme.darkGray};
    padding: 5vh;
    grid-gap: 1em;
    height: 100vh;
    min-width: 20vw;
    grid-auto-rows: max-content;
    transform: translate(${props => (props.showNav ? `99%` : `0`)});
    transition: ${props => props.theme.mediumTrans};
  }
  ${mediaQuery.minPhablet} {
    grid-auto-flow: column;
  }
`

export const NavEntry = styled.div`
  position: relative;
`

export const NavLink = styled(Link)`
  ${navLinkStyle};
`

const showSubNav = css`
  display: grid;
  visibility: visible;
  opacity: 1;
`

export const SubNav = styled.div`
  display: grid;
  width: max-content;
  border-radius: ${props => props.theme.smallBorderRadius};
  grid-gap: 0.5em;
  background: ${props => props.theme.mainGray};
  opacity: 0;
  position: absolute;
  transition: opacity 0.25s;
  padding: 0.7em 1em;
  ${mediaQuery.maxPhablet} {
    ${props => props.showNav && showSubNav + `position: static;`};
  }
  ${mediaQuery.minPhablet} {
    ${NavEntry}:hover & {
      left: 0;
      z-index: 2;
      ${showSubNav}
    }
  }
`

const inNavToggle = css`
  position: absolute;
  top: 0.3em;
  right: 0.5em;
`

const inHeaderToggle = css`
  grid-area: 1 / 1 / 1 / 1;
`

export const Toggle = styled.span`
  font-size: 1.8em;
  cursor: pointer;
  width: max-content;
  ${mediaQuery.minPhablet} {
    display: none;
  }
  ${props => (props.inside ? inNavToggle : inHeaderToggle)};
  ${navLinkStyle};
`
