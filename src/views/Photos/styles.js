import Img from 'gatsby-image'
import styled from 'styled-components'

export { Img }

export const Thumbnail = styled(Img)`
  border-radius: ${props => props.theme.mediumBorderRadius};
  transition: 0.3s;
  height: 100%;
  :hover {
    transform: scale(1.05);
  }
`
