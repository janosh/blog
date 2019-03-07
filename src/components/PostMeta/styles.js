import styled, { css } from "styled-components"
import mediaQuery from "../../utils/mediaQuery"

const inTitle = css`
  margin: 1.3em auto;
  width: max-content;
  a {
    color: ${props => props.theme.lightGreen};
  }
  grid-template-columns: max-content;
  ${mediaQuery.minPhone} {
    grid-auto-flow: column;
  }
`

export const Meta = styled.div`
  display: grid;
  grid-gap: 0.6em 1em;
  font-size: 0.8em;
  grid-template-columns: repeat(auto-fill, minmax(8em, max-content));
  > span {
    display: flex;
    align-items: center;
  }
  ${props => props.inTitle && inTitle};
`
