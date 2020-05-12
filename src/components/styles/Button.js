import styled from 'styled-components'

export const ButtonLink = styled.a`
  background: var(--color-a);
  color: white;
  border-radius: 0.4em;
  padding: 0.3em 0.6em;
  transition: 0.3s;
  display: flex;
  align-items: center;
  margin: 0 auto;
  :hover {
    color: white;
    background: var(--color-d);
  }
`

export const ButtonGroup = styled.div`
  margin: 2em auto;
  border-radius: 0.5em;
  overflow: hidden;
  button {
    font-size: 1.3em;
    border: none;
    outline: none;
    background: var(--color-blue-default);
    color: white;
    padding: 0.2em 0.6em;
    width: max-content;
    font-size: ${props => props.size};
    transition: 0.3s;
    :hover {
      background: var(--color-blue-lighter);
    }
    &.active {
      background: var(--color-blue-dark);
      box-shadow: inset 0 0 0.3em black;
    }
  }
`
