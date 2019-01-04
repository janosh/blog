import styled from 'styled-components'
import { Link } from 'gatsby'

export const Tag = styled(Link)`
  padding: 0 0.5em;
  margin: 0 1em 1em 0;
  white-space: nowrap;
  color: ${props => props.theme.darkGray};
  background: ${props => props.theme.lightGray};
  border-radius: ${props => props.theme.smallBorderRadius};
  &.active {
    background: ${props => props.theme.orange};
  }
`

export const List = styled.div`
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 3em;
`
