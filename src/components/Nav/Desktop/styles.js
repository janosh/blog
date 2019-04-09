import styled from "styled-components"

import { fadeInOnHoverParent } from "../../styles"

export { NavLink } from ".."

export const DesktopNavDiv = styled.nav`
  display: grid;
  grid-gap: calc(1em + 1vw);
  transition: ${props => props.theme.shortTrans};
  max-width: fill-available;
  grid-auto-flow: column;
  grid-auto-columns: max-content;
  justify-self: start;
`

export const NavEntry = styled.div`
  position: relative;
`

export const SubNav = styled.div`
  display: grid;
  width: max-content;
  border-radius: ${props => props.theme.smallBorderRadius};
  grid-gap: 0.2em 0.5em;
  position: absolute;
  transition: ${props => props.theme.shortTrans};
  padding: 0.5em 0.7em;
  grid-template-columns: ${props =>
    props.children.length >= 10 ? `1fr 1fr` : `1fr`};
  background: rgba(0, 0, 0, 0.8);
  ${fadeInOnHoverParent(NavEntry)}
`
