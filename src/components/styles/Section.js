import styled from 'styled-components'

export default styled.div`
  text-align: center;
  > * {
    margin: auto;
    max-width: ${props => props.theme.maxWidth};
  }
`
