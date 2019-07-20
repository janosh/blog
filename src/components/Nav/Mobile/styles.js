import { animated } from 'react-spring'
import styled from 'styled-components'
import { KeyboardArrowDown as More } from 'styled-icons/material/KeyboardArrowDown'
import { KeyboardArrowRight as Arrow } from 'styled-icons/material/KeyboardArrowRight'
import { KeyboardArrowUp as Less } from 'styled-icons/material/KeyboardArrowUp'
import { ThMenu } from 'styled-icons/typicons/ThMenu'
import { NavLink } from '../styles'

export { NavLink }

export const Icons = { More, Less, Arrow }

export const MobileNavDiv = styled.nav`
  position: fixed;
  top: 0;
  overflow: scroll;
  -webkit-overflow-scrolling: touch;
  height: 100%;
  background: rgba(0, 0, 0, 0.85);
  padding: 6vmin;
  font-size: 1.6em;
  color: white;
  right: 100%;
  display: grid;
  grid-gap: 1em;
  grid-auto-columns: max-content;
  grid-auto-rows: max-content;
  transform: translate(${props => (props.open ? `99%` : `0`)});
  transition: ${props => props.theme.shortTrans};
`

export const Item = styled.div`
  a {
    color: white;
  }
  /* target arrow icons prefixing links */
  svg:first-child {
    width: 1em;
    margin-right: 0.2em;
    cursor: pointer;
    vertical-align: -0.15em;
  }
`

export const Children = styled(animated.div)`
  will-change: transform, opacity, height;
  margin-left: 0.5em;
  padding-left: 0.5em;
  border-left: thin dashed white;
  overflow: hidden;
  padding-bottom: ${props => props.open && `0.6em`};
  > div {
    margin-top: 0.6em;
    display: grid;
    grid-gap: 0.6em;
  }
`

export const Menu = styled(NavLink).attrs({
  size: `1em`,
  as: ThMenu,
})`
  cursor: pointer;
  transform: scale(1.7, 1.3);
  margin: 0 0.3em;
`
