import { animated } from 'react-spring'
import styled, { css } from 'styled-components'
import { ThMenu } from 'styled-icons/typicons'
import { NavLink } from '../styles'
import { Close as Cross } from 'styled-icons/material'
import mediaQuery from 'utils/mediaQuery'

export { NavLink }
export { KeyboardArrowDown as ArrowDown } from 'styled-icons/material'
export { KeyboardArrowUp as ArrowUp } from 'styled-icons/material'

export const MobileNavDiv = styled.nav`
  overscroll-behavior: none;
  z-index: 2;
  box-sizing: border-box;
  width: 70vw;
  max-width: 12em;
  position: fixed;
  top: 0;
  overflow: scroll;
  height: 100%;
  background: rgba(0, 0, 0, 0.9);
  padding: 0.8em 1.5em 0.8em 1.8em;
  font-size: 1.2em;
  right: 100%;
  display: grid;
  grid-gap: 1em;
  grid-auto-rows: max-content;
  transform: translate(${props => (props.open ? `99%` : `0`)});
  transition: 0.3s;
  /* Needed to scroll past last element in case of overflow. */
  :after {
    content: '';
    height: 0.5em;
  }
`

export const Item = styled.div`
  /* Target arrow icons prefixing nav links with children. */
  svg:first-child {
    width: 1em;
    margin-right: 0.3em;
    cursor: pointer;
    vertical-align: -0.1em;
  }
`

export const Children = styled(animated.div)`
  will-change: transform, opacity, height;
  margin-left: 0.5em;
  padding-left: 0.8em;
  border-left: thin dashed white;
  overflow: hidden;
  padding-bottom: ${props => props.open && `0.6em`};
  > div {
    margin-top: 0.6em;
    display: grid;
    grid-gap: 0.6em;
  }
`

const openerCss = css`
  z-index: 2;
  position: fixed;
  bottom: 2vh;
  left: 0;
  padding: 0.5em 0.6em 0.5em 0.3em;
  border: 1px solid;
  border-left: none;
  border-radius: 0 50% 50% 0;
  transform: translate(${props => (props.open ? `-100%` : 0)});
`

export const NavToggle = styled(Cross).attrs(props => ({
  as: props.opener && ThMenu,
  size: props.opener ? `1.2em` : `1.6em`,
}))`
  background: ${p => p.opener && `var(--color-background)`};
  transition: 0.3s;
  cursor: pointer;
  :hover {
    transform: scale(1.05);
  }
  ${mediaQuery.minLaptop} {
    display: none;
  }
  ${props => props.opener && openerCss};
`

export const ControlsDiv = styled.div`
  display: grid;
  grid-auto-flow: column;
  border-bottom: 1px solid;
  padding-bottom: 0.3em;
  align-items: center;
  justify-content: space-between;
`
