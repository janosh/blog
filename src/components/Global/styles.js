import { createGlobalStyle } from "styled-components"
import "katex/dist/katex.min.css"

import mediaQuery from "../../utils/mediaQuery"
import typography from "../../utils/typography"

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
    /* below rules enable dark mode */
    will-change: color, background;
    background: ${props => props.theme.background};
    color: ${props => props.theme.textColor};
    a {
      text-decoration: none;
      color: ${props => props.theme.links};
      :hover {
        color: ${props => props.theme.hoveredLinks};
      }
    }
  }
  h1, h2, h3, h4, h5, h6 {
    line-height: initial;
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
    background: ${props => props.theme.buttonBg};
    color: white !important;
    border-radius: ${props => props.theme.smallBorderRadius};
    padding: 0.3em 0.6em;
    transition: ${props => props.theme.shortTrans};
    display: flex;
    align-items: center;
    width: max-content;
    margin: 0 auto;
    :hover {
      background: ${props => props.theme.hoveredButtonBg};
    }
  }
  /* center image captions */
  .gatsby-resp-image-wrapper + em, img + em {
    margin-top: 0.3em;
    display: block;
    text-align: center;
    max-width: 90%;
    margin-left: auto;
    margin-right: auto;
    font-size: 0.95em;
  }
  /* prevent wide equations from breaking layout */
  .katex-display {
    overflow-x: scroll;
    overflow-y: hidden;
  }
  blockquote {
    border-left: 0.25em solid ${props => props.theme.lighterBlue};
    background: ${props => props.theme.quoteBg};
    padding: 0.1em 0 0.1em 1em;
    margin: 0;
  }
`
