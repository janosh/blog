import styled from 'styled-components'

export const SlideContainer = styled.div`
  grid-area: 1 / 1 / 4 / -1;
  display: grid;
  overflow: hidden;
  width: 100%;
  height: 100vh;
`

export const Slide = styled.div`
  grid-area: 1 / 1 / 1 / 1;
  height: 100vh;
  width: 100vw;
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
