import styled, { css } from "styled-components"

import mediaQuery from "../../utils/mediaQuery"

const inTitle = css`
  margin: 1.3em auto;
  width: max-content;
  a {
    color: ${props => props.theme.lightGreen};
  }
`

export const Meta = styled.div`
  display: grid;
  grid-auto-columns: max-content;
  grid-gap: calc(0.5em + 1vw);
  font-size: 0.8em;
  > span {
    display: flex;
    align-items: center;
  }
  ${mediaQuery.minPhone} {
    grid-auto-flow: column;
    > :not(:first-child) {
      padding-left: 0.7em;
      border-left: ${props => props.theme.smallBorder} solid;
    }
  }
  ${props => props.inTitle && inTitle};
`
