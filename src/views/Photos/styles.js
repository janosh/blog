import Img from 'gatsby-image'
import styled from 'styled-components'

export { Img }

export const Thumbnail = styled(Img)`
  border-radius: 0.5em;
  transition: 0.3s;
  height: 100%;
  cursor: pointer;
  :hover {
    transform: scale(1.05);
  }
`
