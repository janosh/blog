import styled from "styled-components"
import mediaQuery from "../../utils/mediaQuery"

export const Tag = styled.button`
  font-size: 1em;
  outline: none;
  cursor: pointer;
  width: max-content;
  white-space: nowrap;
  color: ${props => props.theme.darkGray};
  border-radius: ${props => props.theme.smallBorderRadius};
  background: ${({ active, theme }) =>
    active ? theme.orange : theme.lightGray};
  ${mediaQuery.maxPhablet} {
    padding: 0.1em 0.5em 0.2em;
    margin: 0 1em 1em 0;
  }
`

export const List = styled.div`
  display: grid;
  grid-gap: 1em;
  grid-column: -3;
  height: max-content;
  h2 {
    margin: 0;
  }
  ${mediaQuery.maxPhablet} {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin: 0 0 2em;
    grid-area: 1/3;
    h2 {
      width: 100%;
      margin-bottom: 1em;
      text-align: center;
    }
  }
`
