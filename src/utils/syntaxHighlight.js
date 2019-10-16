import { createGlobalStyle } from 'styled-components'

const langTagColor = [
  { lang: `javascript`, tag: `js`, color: `#f7df1e` },
  { lang: `js`, tag: `js`, color: `#f7df1e` },
  { lang: `jsx`, tag: `jsx`, color: `#61dafb` },
  { lang: `env`, tag: `env`, color: `#ff89d3` },
  { lang: `python`, tag: `py`, color: `#61da84` },
  { lang: `py`, tag: `py`, color: `#61da84` },
  { lang: `graphql`, tag: `graphql`, color: `#e10098` },
  { lang: `gql`, tag: `graphql`, color: `#e10098` },
  { lang: `html`, tag: `html`, color: `#005a9c` },
  { lang: `css`, tag: `css`, color: `#ff9800` },
  { lang: `shell`, tag: `shell`, color: `white` },
  { lang: `sh`, tag: `sh`, color: `white` },
  { lang: `bash`, tag: `bash`, color: `white` },
  { lang: `yml`, tag: `yaml`, color: `linen` },
  { lang: `yaml`, tag: `yaml`, color: `linen` },
  { lang: `markdown`, tag: `md`, color: `#e6ffed` },
  { lang: `md`, tag: `md`, color: `#e6ffed` },
  { lang: `mdx`, tag: `mdx`, color: `#55d179` },
  { lang: `json`, tag: `json`, color: `#fff` },
  { lang: `diff`, tag: `diff`, color: `#e8bd36` },
  { lang: `text`, tag: `text`, color: `gray` },
]

const languageTags = langTagColor.map(
  ({ lang, tag, color }) =>
    `pre.vscode-highlight[data-language="${lang}"]::before {
        content: '${tag}';
        background: ${color};
      }`
)

export default createGlobalStyle`
  ${languageTags.join(`\n`)}

  pre.vscode-highlight {
    position: relative;
    background: #050431;
    font-size: 0.92em;
    border-radius: ${props => props.theme.mediumBorderRadius};
    line-height: 1.5em
  }

  pre.vscode-highlight[data-language]::before {
    position: absolute;
    top: 0;
    right: 2em;
    padding: 0.2em 0.5em;
    font-size: 0.8em;
    font-weight: bold;
    line-height: initial;
    text-transform: uppercase;
    border-radius: 0 0 0.2em 0.2em;
    color: black;
  }

  .gatsby-code-title {
    background: ${props => props.theme.orange};
    color: black;
    padding: 0.2em 0.4em;
    width: max-content;
    margin: 1em 0 -1.6em 1em;
    border-radius: 0.3em;
    position: relative;
    z-index: 1;
    font-size: 0.8em;
    line-height: initial;
  }

  /* highlighted lines */
  .vscode-highlight .vscode-highlight-line-highlighted {
    background: rgba(255, 255, 255, 0.15);
    box-shadow: inset 0.3em 0 0 0 ${props => props.theme.lighterBlue};
  }

  /* inline code */
  :not(pre) > code {
    border-radius: 0.2em;
    background: ${props => props.theme.inlineCodeColor};
    padding: 0.15em 0.2em;
  }
`
