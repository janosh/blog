import styled from 'styled-components'

export default styled.div`
  display: grid;
  grid-template-columns: repeat(
    auto-fit,
    minmax(${props => props.min || `5em`}, 1fr)
  );
  grid-gap: calc(1em + 2vw);
  img {
    width: 100%;
  }
`
