import styled from 'styled-components'
import { Link } from 'gatsby'

export const CategoryLink = styled(Link)`
  display: flex;
  width: max-content;
  padding: 0 0.5rem;
  margin: 0 1rem 1rem 0;
  color: ${props => props.theme.darkGray} !important;
  background: ${props => props.theme.lightGray};
  border-radius: ${props => props.theme.mediumBorderRadius};
  &.${props => props.activeClassName} {
    background: ${props => props.theme.mainOrange};
  }
`

export const List = styled.div`
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 2rem;
`