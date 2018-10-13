import styled from 'styled-components'
import Image from 'gatsby-image'

export const Article = styled.article`
  display: grid;
  grid-template-areas:
    'cover title'
    'cover postmeta'
    'cover .'
    'excerpt excerpt';
  grid-gap: calc(0.5em + 1vh) calc(1em + 1vw);
  & + & {
    margin-top: 3em;
  }
`

export const Title = styled.h1`
  grid-area: title;
  margin: 0;
  font-size: 2em;
`

export const Img = styled(Image)`
  grid-area: cover;
  border-radius: ${props => props.theme.mediumBorderRadius};
`

export const Excerpt = styled.p`
  grid-area: excerpt;
  margin: 0;
`
