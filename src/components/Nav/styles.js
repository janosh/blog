import { Link } from 'gatsby'
import styled from 'styled-components'

export const NavLink = styled(Link).attrs({
  activeClassName: `active`,
  partiallyActive: true,
})`
  color: inherit;
  transition: ${props => props.theme.shortTrans};
  &.active {
    color: ${props => props.theme.orange};
  }
  :hover {
    color: ${props => props.theme.lighterBlue};
  }
`
