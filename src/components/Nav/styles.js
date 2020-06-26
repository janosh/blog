import styled from 'styled-components'
import { ThMenu } from 'styled-icons/typicons'
import { Close as Cross } from 'styled-icons/material'
import mediaQuery from 'utils/mediaQuery'
import { Link } from 'gatsby'

// Unable to accommodate expanding search box via overflow-x: scroll;
// here because of https://stackoverflow.com/a/6433475. Would include
// potential future SubNavs in vertical scrolling, effectively hiding them.
export const NavDiv = styled.nav`
  font-size: 1.1em;
  display: grid;
  grid-gap: calc(1em + 1vw);
  transition: 0.3s;
  /* Desktop */
  ${mediaQuery.minTablet} {
    grid-auto-flow: column;
    justify-self: start;
  }
  /* Mobile */
  ${mediaQuery.maxTablet} {
    box-sizing: border-box;
    background: rgba(0, 0, 0, 0.9);
    overscroll-behavior: none;
    z-index: 2;
    transform: translate(${props => (props.open ? `99%` : `0`)});
    grid-auto-rows: max-content;
    width: 70vw;
    max-width: 12em;
    position: fixed;
    top: 0;
    padding: 2em 1.5em 0.8em 1.8em;
    height: 100%;
    right: 100%;
    /* Needed to scroll past last element in case of overflow. */
    :after {
      content: '';
      height: 0.5em;
    }
  }
`

export const NavToggle = styled(Cross).attrs(props => ({
  as: props.opener && ThMenu,
  size: props.opener ? `1.2em` : `1.6em`,
}))`
  transition: 0.3s;
  cursor: pointer;
  :hover {
    transform: scale(1.05);
  }
  ${p =>
    !p.opener &&
    `position: absolute;
    top: 0.7em;
    right: 0.5em;`}
  ${mediaQuery.minTablet} {
    display: none;
  }
`

export const NavLink = styled(Link).attrs({
  activeClassName: `active`,
  partiallyActive: true,
})`
  white-space: nowrap;
  color: inherit;
  transition: 0.3s;
  &.active {
    color: var(--color-a);
  }
  :hover {
    color: var(--color-blue-light);
  }
`
