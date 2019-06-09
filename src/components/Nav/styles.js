import styled, { css } from "styled-components"
import { Link } from "gatsby"

export const navLinkStyle = css`
  color: white;
  transition: ${props => props.theme.shortTrans};
  &.active {
    color: ${props => props.theme.orange};
  }
  :hover {
    color: ${props => props.theme.lighterBlue};
  }
`

export const NavLink = styled(Link).attrs({
  activeClassName: `active`,
  partiallyActive: true,
})`
  ${navLinkStyle};
`
