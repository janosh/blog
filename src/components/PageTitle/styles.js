import styled from 'styled-components'
import Img from 'gatsby-image'

export const Title = styled.header`
  margin-bottom: calc(2em + 2vh);
  grid-column: 2 / -2;
  grid-row: 1;
  text-align: center;
  color: ${props => props.theme.mainWhite};
  font-size: calc(1em + 1vw);
  align-self: center;
`

export const Background = styled(Img)`
  margin-bottom: calc(2em + 2vh);
  z-index: -1;
  grid-row: 1;
  height: 40vh;
  top: 0;
  left: 0;
  grid-column: 1 / -1 !important;
  img {
    object-position: bottom !important;
  }
`
