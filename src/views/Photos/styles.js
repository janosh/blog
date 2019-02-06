import styled, { css } from "styled-components"
import Img from "gatsby-image"

export const Thumbnail = styled(Img)`
  border-radius: ${props => props.theme.mediumBorderRadius};
`

export const LargeImg = styled(Img)`
  width: 80vw;
  height: 80vh;
`

export const modalCss = css`
  padding: 0;
  max-width: 80vw;
`
