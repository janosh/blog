import styled from 'styled-components'

// Adapted from https://tobiasahlin.com/spinkit.
export const FoldingDiv = styled.div`
  margin: 2em auto;
  width: 2em;
  height: 2em;
  transform: rotateZ(45deg);
  div {
    float: left;
    width: 50%;
    height: 50%;
    position: relative;
    transform: scale(1.1);
  }
  div:before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: var(--color-text);
    ${props => props.active && `animation: foldCube 2.4s infinite linear both`};
    transform-origin: 100% 100%;
  }
  ${[2, 4, 3]
    .map(
      (el, idx) => `div:nth-child(${el}) {
        transform: scale(1.1) rotateZ(${90 * (idx + 1)}deg);
      }
      div:nth-child(${el}):before {
        animation-delay: ${0.3 * (idx + 1)}s;
      }`
    )
    .join(`\n`)}
  @keyframes foldCube {
    0%,
    10% {
      transform: perspective(140px) rotateX(-180deg);
      opacity: 0;
    }
    25%,
    75% {
      transform: perspective(140px) rotateX(0deg);
      opacity: 1;
    }
    90%,
    100% {
      transform: perspective(140px) rotateY(180deg);
      opacity: 0;
    }
  }
`
