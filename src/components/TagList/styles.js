import styled from "styled-components"

export const Tag = styled.button`
  font-size: 1em;
  outline: none;
  cursor: pointer;
  padding: 0.1em 0.5em 0.2em;
  margin: 0 1em 1em 0;
  white-space: nowrap;
  color: ${props => props.theme.darkGray};
  border-radius: ${props => props.theme.smallBorderRadius};
  background: ${({ active, theme }) =>
    active ? theme.orange : theme.lightGray};
`

export const List = styled.div`
  display: flex;
  flex-wrap: wrap;
  margin: 2em 0;
  grid-column: 2 / -2;
  justify-content: center;
`
