import styled from 'styled-components'

export const DotsContainer = styled.div`
  display: grid;
  grid-area: dots;
  grid-gap: 1vw;
  grid-auto-flow: column;
  color: ${props => props.theme.mainWhite};
  z-index: 3;
  justify-content: center;
  ${props => props.css};
`

export const Dot = styled.div`
  border-radius: 50%;
  height: ${props => props.size || `0.8em`};
  width: ${props => props.size || `0.8em`};
  background: rgba(0, 0, 0, 0.5);
  background: ${props => props.active && props.theme.lightGreen};
  transition: ${props => props.theme.mediumTrans};
  border: 1px solid ${props => props.theme.mainWhite};
  :hover {
    color: ${props => props.theme.lightBlue};
    background: ${props => props.theme.darkBlue};
    transform: scale(1.2);
    border: 1px solid ${props => props.theme.lightBlue};
  }
`
