import styled from 'styled-components'

export default styled.div`
  padding: calc(3em + 5vh) calc(3em + 5vw);
  text-align: center;
  > * {
    margin: auto;
    max-width: ${props => props.theme.maxWidth};
  }
`
