import styled, { css } from "styled-components"
import Image from "gatsby-image"

export const PageTitleContainer = styled.hgroup`
  position: relative;
  color: ${props => props.theme.white};
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
  flex: 1; /* for filling height between header and footer on 404 page */
`

const backdrop = css`
  > * {
    background: rgba(0, 0, 0, 0.7);
    border-radius: ${props => props.theme.smallBorderRadius};
    justify-self: center;
    padding: 0.1em 0.4em;
  }
`

export const Title = styled.div`
  text-align: center;
  font-size: calc(1em + 0.5vw);
  margin: 1em;
  ${props => props.backdrop && backdrop};
`

export const Img = styled(Image).attrs(
  ({ fluid, src }) => !fluid && { as: (src && `img`) || `div` }
)`
  position: absolute !important;
  z-index: -1;
  width: 100%;
  height: 100%;
  background: ${props => props.as === `div` && `linear-gradient(
    28deg,
    rgba(255, 113, 0, 1) 0%,
    rgba(9, 9, 121, 1) 50%,
    rgba(0, 212, 255, 1) 100%
  )`};
  object-fit: cover;
`
