import 'katex/dist/katex.min.css'
import { createGlobalStyle } from 'styled-components'
import mediaQuery, { screens } from 'utils/mediaQuery'
import typography from 'utils/typography'

const { phone, desktop } = screens
const { fonts, minFontSize, maxFontSize, minLineHeight, maxLineHeight } = typography

export const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    hyphens: auto;
    font-family: ${fonts};
    font-size: ${minFontSize}em;
    line-height: ${minLineHeight}em;
    /* Fix very large font size in code blocks in iOS Safari (https://stackoverflow.com/a/3428477). */
    -webkit-text-size-adjust: 100%;
    ${mediaQuery.minPhone} {
      font-size: calc(${minFontSize}em + (${maxFontSize} - ${minFontSize}) * ((100vw - ${phone}em) / (${desktop} - ${phone})));
      line-height: calc(${minLineHeight}em + (${maxLineHeight} - ${minLineHeight}) * ((100vw - ${phone}em) / (${desktop} - ${phone})));
    }
    ${mediaQuery.minDesktop} {
      font-size: ${maxFontSize}em;
      line-height: ${maxLineHeight}em;
    }
    /* Ensure full-height page even if insufficient content. */
    #gatsby-focus-wrapper {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    /* The rules below enable dark mode. */
    background: var(--color-background);
    color: var(--color-text);
    a {
      text-decoration: none;
      color: var(--color-link);
      :hover {
        color: var(--color-a);
      }
    }
  }
  h1, h2, h3, h4, h5, h6 {
    line-height: initial;
  }
  /* Prevent wide equations from breaking layout. */
  .katex-display {
    overflow-x: scroll;
    overflow-y: hidden;
  }
  blockquote, details {
    border-left: 0.25em solid var(--color-link);
    background: var(--color-accentBackground);
    padding: 0.1em 0.3em 0.1em 1em;
    margin: 0;
    summary {
      font-weight: bold;
    }
  }
  table {
    border-collapse: collapse;
    width: 100%;
  }
  table td, table th {
    border: 1px solid var(--color-text);
    padding: 0.2em 0.6em;
  }
  tbody tr:nth-child(odd) {
    background: var(--color-accentBackground);
  }
  div.scroll {
    overflow: scroll;
    margin: 1em auto;
    border: 1px solid var(--color-text);
    border-width: 0 1px;
    white-space: nowrap;
    table td, table th {
      :first-child {
        border-left: none;
      }
      :last-child {
        border-right: none;
      }
    }
  }
`
