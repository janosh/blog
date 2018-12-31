import styled from 'styled-components'
import Image from 'gatsby-image'

export const Container = styled.header`
  grid-column: 1 / -1;
  position: relative;
  color: ${props => props.theme.white};
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 50vh;
  max-height: 70vh;
  margin-bottom: calc(3em + 3vh);
`

export const Img = styled(Image)`
  position: absolute !important;
  z-index: -1;
  width: 100%;
  height: 100%;
`

export const Title = styled.h1`
  background: rgba(0, 0, 0, 0.5);
  border-radius: ${props => props.theme.mediumBorderRadius};
  padding: 0.1em 0.5em;
`
