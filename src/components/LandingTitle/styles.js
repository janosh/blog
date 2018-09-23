import styled from 'styled-components'
import Img from 'gatsby-image'
import mediaQuery from '../../utils/mediaQuery'

export const Title = styled.header`
  grid-area: 2 / 2 / 2 / -2;
  justify-self: center;
  justify-items: center;
  padding: calc(0.5em + 2vh) calc(0.5em + 2vw);
  z-index: 2;
  color: ${props => props.theme.mainWhite};
  border-radius: ${props => props.theme.smallBorderRadius};
  background: rgba(0, 0, 0, 0.4);
  display: grid;
  grid-gap: 1em;
  grid-template-areas:
    'me'
    'hello'
    'about';
  ${mediaQuery.minPhone} {
    grid-template-areas:
      'me hello'
      'about about';
    grid-template-columns: min-content;
  }
  a {
    color: ${props => props.theme.mainOrange};
  }
  max-width: 25em;
`

export const Hello = styled.div`
  grid-area: hello;
  display: grid;
  align-content: space-between;
  > * {
    margin: 0;
  }
`

export const Me = styled(Img)`
  grid-area: me;
  border-radius: 50%;
  height: 6em;
  width: 6em;
`
