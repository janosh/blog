import { Link } from 'gatsby'
import styled from 'styled-components'

export const NavLink = styled(Link).attrs({
  activeClassName: `active`,
  partiallyActive: true,
})`
  color: inherit;
  transition: 0.3s;
  &.active {
    color: var(--color-a);
  }
  :hover {
    color: var(--color-blue-light);
  }
`
