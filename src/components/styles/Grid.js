import styled from "styled-components"

export const Grid = styled.div`
  display: grid;
  grid-template-columns: repeat(
    auto-fit,
    minmax(${props => props.minWidth || `5em`}, 1fr)
  );
  grid-gap: ${props => props.gap || `calc(1em + 1vw)`};
  text-align: ${props => props.align};
  max-width: ${props => props.children.length === 1 && props.maxWidth};
  grid-auto-rows: ${props => props.height};
`
