import styled, { css } from 'styled-components'

import mediaQuery from '../../utils/mediaQuery'

const inTitle = css`
  justify-items: center;
  padding: 0.2em 1em;
  margin: 1.3em 0;
  background: rgba(0, 0, 0, 0.5);
  border-radius: ${props => props.theme.mediumBorderRadius};
  a {
    color: ${props => props.theme.lightGreen};
  }
`

export const Meta = styled.div`
  grid-area: postmeta;
  display: grid;
  grid-auto-columns: max-content;
  grid-gap: calc(0.5em + 1vw);
  font-size: 0.9em;
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
