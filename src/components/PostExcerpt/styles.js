import styled from "styled-components"
import Img from "gatsby-image"

export const Post = styled.article`
  height: 100%;
  width: 100%;
  display: grid;
  border-radius: ${props => props.theme.mediumBorderRadius};
  border: 1px solid ${props => props.theme.lightGray};
  box-shadow: 0 0 1em ${props => props.theme.lightGray};
  overflow: hidden;
  > :not(:first-child) {
    margin-left: 20px;
    margin-right: 20px;
  }
  > :last-child {
    margin-bottom: 0.5em;
  }
`

export const Cover = styled(Img).attrs(
  ({ fluid, src }) => !fluid && { as: (src && `img`) || `div` }
)`
  height: calc(10em + 4vh);
  width: 100%;
  object-fit: cover;
`
