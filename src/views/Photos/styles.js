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

export const Caption = styled.h3`
  position: absolute;
  bottom: 0;
  right: 1.3em;
  margin: 0;
  padding: 0.1em 0.5em;
  color: white;
  border-radius: ${props => (props.theme.mediumBorderRadius + ` `).repeat(2)} 0
    0;
  background: rgba(0, 0, 0, 0.7);
`
