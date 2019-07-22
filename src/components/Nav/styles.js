import { Link } from 'gatsby'
import styled, { css } from 'styled-components'

export const navLinkStyle = css`
  color: inherit;
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
