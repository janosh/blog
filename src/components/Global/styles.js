import { createGlobalStyle } from 'styled-components'
import 'katex/dist/katex.min.css'

import mediaQuery from '../../utils/mediaQuery'
import typography from '../../utils/typography'

const { phone, desktop } = mediaQuery.screens
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
    hyphens: auto;
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
    /* ensure full height page even if unsufficient content */
    div[role="group"][tabindex] {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      main {
        flex: 1;
      }
    }
  }
  h1, h2, h3, h4, h5, h6 {
    line-height: initial;
  }
  a {
    text-decoration: none;
    color: ${props => props.theme.blue};
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
  .button {
    background: ${props => props.theme.blue};
    color: white !important;
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
  /* center image captions */
  .gatsby-resp-image-wrapper + em {
    margin-top: 0.3em;
    display: block;
    text-align: center;
  }
  /* prevent wide equations from breaking layout */
  .katex-display {
    overflow-x: scroll;
  }
  blockquote {
    border-left: 0.25em solid ${props => props.theme.lightBlue};
    background: rgba(0, 0, 0, 0.03);
    padding: 0.1em 0 0.1em 1em;
    margin: 0;
  }
`
