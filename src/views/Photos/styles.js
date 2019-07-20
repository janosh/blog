import Img from 'gatsby-image'
import styled from 'styled-components'

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
