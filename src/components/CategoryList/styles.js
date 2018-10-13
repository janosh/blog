import styled from 'styled-components'
import { Link } from 'gatsby'

export const CategoryLink = styled(Link)`
  padding: 0 0.5em;
  margin-right: 1em;
  color: ${props => props.theme.darkGray};
  background: ${props => props.theme.lightGray};
  border-radius: ${props => props.theme.smallBorderRadius};
  &.${props => props.activeClassName} {
    background: ${props => props.theme.mainOrange};
  }
`

export const List = styled.div`
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 3em;
`
