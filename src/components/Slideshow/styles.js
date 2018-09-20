import styled from 'styled-components'

export const SlideContainer = styled.div`
  display: grid;
  height: 100vh;
  overflow: hidden;
  position: absolute;
  width: 100%;
  height: 100vh;
  z-index: -1;
`

export const Slide = styled.div`
  grid-area: 1 / 1 / 1 / 1;
  height: 100%;
  width: 100%;
  object-fit: cover;
  .gatsby-image-wrapper {
    height: 100%;
  }
  opacity: ${props => (props.active ? 1 : 0)};
  visibility: ${props => (props.active ? `visible` : `hidden`)};
  transform: scale(${props => (props.active ? 1 : 1.4)});
  transition: 1s ease-in;
  overflow: hidden;
  position: relative;
  animation: kenburns ${props => 8 * props.delay}s linear infinite;
  @keyframes kenburns {
    0% {
      transform: scale(1) translate(0);
    }
    25% {
      transform: scale(1.2) translate(3%, 1%);
    }
    50% {
      transform: scale(1) translate(0);
    }
    75% {
      transform: scale(1.2) translate(-3%, -1%);
    }
    100% {
      transform: scale(1) translate(0);
    }
  }
`

export const Dots = styled.div`
  position: absolute;
  left: 50%;
  transform: translate(-50%);
  bottom: 1em;
  display: grid;
  grid-gap: 1vw;
  grid-auto-flow: column;
  color: ${props => props.theme.mainWhite};
`

export const Dot = styled.div`
  border-radius: 50%;
  height: 0.8em;
  width: 0.8em;
  background: rgba(0, 0, 0, 0.5);
  background: ${props => props.active && props.theme.lightGreen};
  transition: ${props => props.theme.mediumTrans};
  border: ${({ theme }) => theme.smallBorder + ` solid ` + theme.mainWhite};
  :hover {
    color: ${props => props.theme.lightBlue};
    background: ${props => props.theme.darkBlue};
    transform: scale(1.2);
    border: ${({ theme }) => theme.smallBorder + ` solid ` + theme.lightBlue};
  }
`
