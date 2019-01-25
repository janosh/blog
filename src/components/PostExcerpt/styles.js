import styled from "styled-components"
import Img from "gatsby-image"

export const Post = styled.article`
  height: 100%;
  display: grid;
  background: ${props => props.theme.veryLightGray};
  border-radius: ${props => props.theme.mediumBorderRadius};
  border: 1px solid ${props => props.theme.lightGray};
  overflow: hidden;
  > main {
    display: grid;
    grid-gap: 0.5em;
    padding: 0.7em 1em;
    h3,
    p {
      margin: 0;
    }
  }
  a:first-child {
    height: min-content;
  }
`

export const Cover = styled(Img)`
  height: calc(10em + 4vh);
`
