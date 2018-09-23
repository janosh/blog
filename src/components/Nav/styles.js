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

export const Container = styled.nav`
  grid-area: nav;
  display: grid;
  grid-gap: 3vw;
  grid-auto-columns: max-content;
  ${mediaQuery.phablet} {
    position: fixed;
    right: 100%;
    z-index: 2;
    background: ${props => props.theme.darkGray};
    padding: 5vh;
    grid-gap: 1em;
    height: 100vh;
    min-width: 15vw;
    grid-auto-rows: max-content;
    transform: translate(${props => (props.showNav ? `99%` : `0`)});
    transition: ${props => props.theme.mediumTrans};
  }
  ${mediaQuery.minPhablet} {
    grid-auto-flow: column;
  }
`

export const NavLink = styled(Link)`
  ${navLinkStyle};
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
