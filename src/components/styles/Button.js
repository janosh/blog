import styled from 'styled-components'

export const ButtonLink = styled.a`
  background: ${props => props.theme.buttonBg};
  color: white;
  border-radius: 0.4em;
  padding: 0.3em 0.6em;
  transition: ${props => props.theme.shortTrans};
  display: flex;
  align-items: center;
  margin: 0 auto;
  :hover {
    color: white;
    background: ${props => props.theme.hoveredButtonBg};
  }
`

export const ButtonGroup = styled.div`
  margin: 2em auto;
  border-radius: ${props => props.theme.mediumBorderRadius};
  overflow: hidden;
  button {
    font-size: 1.3em;
    border: none;
    outline: none;
    background: ${props => props.theme.blue};
    color: white;
    padding: 0.2em 0.6em;
    width: max-content;
    font-size: ${props => props.size};
    transition: ${props => props.theme.shortTrans};
    :hover {
      background: ${props => props.theme.lighterBlue};
    }
    &.active {
      background: ${props => props.theme.darkerBlue};
      box-shadow: inset 0 0 0.3em black;
    }
  }
`
