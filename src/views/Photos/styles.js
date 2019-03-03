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

export const LargeImg = styled(Img)`
  width: 80vw;
  height: 80vh;
`
