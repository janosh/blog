import styled, { css } from 'styled-components'
import Img from 'gatsby-image'

const backdrop = css`
  background: rgba(0, 0, 0, 0.5);
  border-radius: ${props => props.theme.mediumBorderRadius};
  > * {
    margin: 0.2em;
    width: max-content;
  }
`

export const Title = styled.header`
  grid-column: 2 / -2;
  grid-row: 1;
  text-align: center;
  color: ${props => props.theme.white};
  font-size: calc(1em + 1vw);
  align-self: center;
  ${props => props.backdrop && backdrop};
`

export const Background = styled(Img)`
  margin-bottom: calc(2em + 2vh);
  z-index: -1;
  grid-row: 1;
  height: 70vh;
  top: 0;
  left: 0;
  grid-column: 1 / -1 !important;
`
