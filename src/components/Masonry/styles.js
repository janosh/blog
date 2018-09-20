import styled from 'styled-components'

export const MasonryDiv = styled.div`
  display: grid;
  grid-auto-flow: column;
  grid-gap: ${props => props.gap || `1em`};
`

export const Col = styled.div`
  display: grid;
  grid-gap: ${props => props.gap || `1em`};
`
