import styled from "styled-components"
import Img from "gatsby-image"

export const Thumbnail = styled(Img)`
  border-radius: ${props => props.theme.mediumBorderRadius};
  transition: ${props => props.theme.shortTrans};
  height: 100%;
  :hover {
    transform: scale(1.05);
  }
`

export const LargeImg = styled(Img).attrs(
  props =>
    props.fluid.aspectRatio < 1.45 && {
      imgStyle: { objectFit: `contain` },
    }
)`
  width: 80vw;
  background: rgba(0, 0, 0, 0.9);
  height: max-content;
  max-height: 80vh;
`
