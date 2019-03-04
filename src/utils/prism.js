import { createGlobalStyle } from "styled-components"

const langExtColor = [
  { lang: `javascript`, tag: `js`, color: `#f7df1e` },
  { lang: `js`, tag: `js`, color: `#f7df1e` },
  { lang: `jsx`, tag: `jsx`, color: `#61dafb` },
  { lang: `env`, tag: `env`, color: `#6162fb`, textColor: `#cceffb` },
  { lang: `python`, tag: `py`, color: `#61da84` },
  { lang: `py`, tag: `py`, color: `#61da84` },
  { lang: `graphql`, tag: `graphql`, color: `#E10098` },
  { lang: `gql`, tag: `graphql`, color: `#E10098` },
  { lang: `html`, tag: `html`, color: `#005A9C` },
  { lang: `css`, tag: `css`, color: `#ff9800` },
  { lang: `shell`, tag: `shell`, color: `white` },
  { lang: `sh`, tag: `sh`, color: `white` },
  { lang: `bash`, tag: `bash`, color: `white` },
  { lang: `yml`, tag: `yml`, color: `linen` },
  { lang: `yaml`, tag: `yaml`, color: `linen` },
  { lang: `markdown`, tag: `md`, color: `#e6ffed` },
  { lang: `json`, tag: `json`, color: `#fff` },
  { lang: `diff`, tag: `diff`, color: `#E8BD36` },
  { lang: `text`, tag: `text`, color: `gray` },
]

const languageTags = langExtColor
  .map(
    ({ lang, tag, color, textColor }) =>
      `.gatsby-highlight pre[class='language-${lang}']::before {
        content: '${tag}';
        background: ${color};
        color: ${textColor};
      }`
  )
  .join(`\n`)

export default createGlobalStyle`
  code[class*='language-'],
  pre[class*='language-'] {
    position: relative;
    overflow: hidden;
    color: white;
    background: none;
    font-family: Consolas, Menlo, Monaco, source-code-pro, 'Courier New', monospace;
    text-align: left;
    white-space: pre;
    word-spacing: normal;
    word-break: normal;
    word-wrap: normal;
    line-height: 1.5;
    font-size: 0.9em;
    tab-size: 4;
    hyphens: none;
  }

  pre[class*='language-'],
  :not(pre) > code[class*='language-'] {
    background: #011627;
  }

  /* Code blocks */
  pre[class*='language-'] {
    border-radius: ${props => props.theme.mediumBorderRadius};
    overflow: auto;
    padding: 1em;
  }

  pre[class*='language-']::selection {
    /* Safari */
    background: hsl(207, 4%, 16%);
  }

  pre[class*='language-']::selection,
  pre[class*='language-'] ::selection,
  code[class*='language-']::selection,
  code[class*='language-'] ::selection {
    text-shadow: none;
    background: hsla(0, 0%, 93%, 0.15);
  }

  /* Inline code */
  :not(pre) > code[class*='language-'] {
    border-radius: 0.2em;
    background: ${props => props.theme.lightGray};
    color: ${props => props.theme.black};
    padding: 0.15em 0.2em 0.05em;
  }

  .token.attr-name {
    color: rgb(173, 219, 103);
    font-style: italic;
  }

  .token.comment {
    color: rgb(99, 119, 119);
  }

  .token.string,
  .token.url {
    color: rgb(173, 219, 103);
  }

  .token.variable {
    color: rgb(214, 222, 235);
  }

  .token.number {
    color: rgb(247, 140, 108);
  }

  .token.builtin,
  .token.char,
  .token.constant,
  .token.function {
    color: rgb(130, 170, 255);
  }

  .token.punctuation {
    color: rgb(199, 146, 234);
  }

  .token.selector,
  .token.doctype {
    color: rgb(199, 146, 234);
    font-style: 'italic';
  }

  .token.class-name {
    color: rgb(255, 203, 139);
  }

  .token.tag,
  .token.operator,
  .token.keyword {
    color: #ffa7c4;
  }

  .token.boolean {
    color: rgb(255, 88, 116);
  }

  .token.property {
    color: rgb(128, 203, 196);
  }

  .token.namespace {
    color: rgb(178, 204, 214);
  }

  pre[data-line] {
    padding: 1em 0 1em 3em;
    position: relative;
  }

  .gatsby-highlight-code-line {
    background-color: hsla(207, 95%, 15%, 1);
    display: block;
    margin-right: -1em;
    margin-left: -1em;
    padding-right: 1em;
    padding-left: 0.75em;
    border-left: 0.25em solid ${props => props.theme.lightBlue};
  }

  .gatsby-highlight {
    overflow: auto;
  }

  .gatsby-highlight pre[class*='language-']::before {
    position: absolute;
    z-index: 1;
    top: 0px;
    right: 2em;
    padding: 0.1em 0.5em;
    font-size: 0.7em;
    text-align: right;
    color: black;
    font-weight: bold;
    text-transform: uppercase;
    border-radius: 0 0 0.2em 0.2em;
    background: #ddd;
  }
  ${languageTags}
`
