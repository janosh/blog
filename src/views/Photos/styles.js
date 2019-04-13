import styled from "styled-components"
import Img from "gatsby-image"

export { Img }

export const Thumbnail = styled(Img)`
  border-radius: ${props => props.theme.mediumBorderRadius};
  transition: ${props => props.theme.shortTrans};
  height: 100%;
  cursor: pointer;
  :hover {
    transform: scale(1.05);
  }
`
