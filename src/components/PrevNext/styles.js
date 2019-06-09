import styled from "styled-components"
import Image from "gatsby-image"

export const PreviousNext = styled.div`
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  margin-top: 3em;
  position: relative;
`

export const Thumbnail = styled.div`
  border-radius: ${props => props.theme.mediumBorderRadius};
  overflow: hidden;
  position: relative;
  text-align: center;
  .gatsby-image-wrapper,
  img {
    width: 12em;
    height: 7em;
  }
  h4 {
    width: 100%;
    box-sizing: border-box;
    padding: 0.5em;
    color: white;
    position: absolute;
    bottom: 0;
    margin: 0;
    background: rgba(0, 0, 0, 0.5);
  }
`

export const Img = styled(Image).attrs(({ fluid }) => !fluid && { as: `img` })`
  height: calc(10em + 4vh);
  width: 100%;
  object-fit: cover;
`
