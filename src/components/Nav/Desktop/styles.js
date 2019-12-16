import styled from 'styled-components'
import { fadeInOnHoverParent } from '../../styles'

export { DownArrow } from 'styled-icons/boxicons-solid/DownArrow'

// Unable to accomodate expanding search box via overflow-x: scroll;
// here because of https://stackoverflow.com/a/6433475. Would include
// potential future SubNavs in vertical scrolling, effectively hiding them.
export const DesktopNavDiv = styled.nav`
  display: grid;
  grid-gap: calc(1em + 1vw);
  transition: 0.3s;
  grid-auto-flow: column;
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
