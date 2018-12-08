import styled, { createGlobalStyle } from 'styled-components'
import 'katex/dist/katex.min.css'

import mediaQuery, { screenSize } from '../../utils/mediaQuery'
import typography from '../../utils/typography'

const { phone, desktop } = screenSize
const {
  fonts,
  minFontSize,
  maxFontSize,
  minLineHeight,
  maxLineHeight,
} = typography

export const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    font-family: ${fonts};
    font-size: ${minFontSize}em;
    line-height: ${minLineHeight}em;
    ${mediaQuery.minPhone} {
      font-size: calc(${minFontSize}em + (${maxFontSize} - ${minFontSize}) * ((100vw - ${phone}em) / (${desktop} - ${phone})));
      line-height: calc(${minLineHeight}em + (${maxLineHeight} - ${minLineHeight}) * ((100vw - ${phone}em) / (${desktop} - ${phone})));
    }
    ${mediaQuery.minDesktop} {
      font-size: ${maxFontSize}em;
      line-height: ${maxLineHeight}em;
    }
    > * > * {
      min-height: 100vh;
      display: grid;
      grid-template-rows: auto 1fr auto;
    }
  }
  h1, h2, h3, h4, h5, h6 {
    line-height: initial;
  }
  a {
    text-decoration: none;
    color: ${props => props.theme.mainBlue};
    :hover {
      color: ${props => props.theme.lightBlue};
    }
  }
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(8em, 1fr));
    grid-gap: 1em 2em;
    text-align: center;
    &.docs {
    grid-gap: 1em;
      p {
        margin: 0;
      }
      img {
        border: 1px solid lightgray;
        border-radius: 5px;
        overflow: hidden;
      }
    }
  }
  .btn {
    background: ${props => props.theme.mainBlue};
    color: ${props => props.theme.mainWhite} !important;
    border-radius: ${props => props.theme.smallBorderRadius};
    padding: 0.3em 0.6em;
    transition: ${props => props.theme.shortTrans};
    display: flex;
    align-items: center;
    width: max-content;
    margin: 0 auto;
    :hover {
      background: ${props => props.theme.lightBlue};
    }
  }
`

export const Layout = styled.main`
  margin-bottom: ${props => props.margin || `calc(3em + 3vh)`};
  display: grid;
  grid-gap: 0 4vw;
  grid-template-columns: 1fr 1fr minmax(auto, ${props => props.theme.maxWidth}) 1fr 1fr;
  grid-auto-rows: max-content;
  > * {
    grid-column: 3;
  }
`
