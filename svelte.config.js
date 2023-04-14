import adapter from '@sveltejs/adapter-static'
import { s } from 'hastscript'
import { mdsvex } from 'mdsvex'
import link_headings from 'rehype-autolink-headings'
import katex from 'rehype-katex-svelte'
import heading_slugs from 'rehype-slug'
import math from 'remark-math'
import preprocess from 'svelte-preprocess'
import { importAssets } from 'svelte-preprocess-import-assets'

const macros = {
  // Infinitesimal differential (used in derivatives and integrals)
  '\\dif': `\\mathrm d`,
  // Vector
  '\\vec': `{\\boldsymbol{#1}}`,
  // Matrix
  '\\mat': `{\\boldsymbol{#1}}`,
  // Real line
  '\\reals': `{\\mathbb{R}}`,
  // Complex plane
  '\\comps': `{\\mathbb{C}}`,
  // Integers
  '\\ints': `{\\mathbb{Z}}`,
  // Expectation value
  '\\expec': `\\mathbb{E}`,
  // Variance
  '\\var': `\\operatorname{var}`,
  // Matrix diagonal
  '\\diag': `\\operatorname{diag}`,
  // Unit/identity matrix
  '\\unity': `\\mat{\\mathbb{I}}`,
  // Used in equations to hide non-essential constants
  '\\const': `\\text{const}`,
  // Absolute value
  '\\abs': `\\left|#1\\right|`,
  // Adaptive parentheses
  '\\paren': `\\mathopen{}\\left(#1\\right)\\mathclose{}`,
  // Adaptive brackets
  '\\brkt': `\\mathopen{}\\left[#1\\right]\\mathclose{}`,
  // Adaptive curly brackets
  '\\cbrkt': `\\mathopen{}\\left\\{#1\\right\\}\\mathclose{}`,
}

for (let index = `A`.charCodeAt(); index <= `Z`.charCodeAt(); index++) {
  const letter = String.fromCharCode(index)
  // Caligraphic letters
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  // Blackboard bold letters
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

const rehypePlugins = [
  [
    katex,
    {
      macros,
      throwOnError: false,
      errorColor: `#cc0000`,
    },
  ],
  heading_slugs,
  [
    link_headings,
    {
      behavior: `append`,
      test: [`h2`, `h3`, `h4`, `h5`, `h6`], // don't auto-link <h1>
      content: s(
        `svg`,
        { width: 16, height: 16, viewBox: `0 0 16 16` },
        // symbol #octicon-link defined in app.html
        s(`use`, { 'xlink:href': `#octicon-link` })
      ),
    },
  ],
]

/** @type {import('@sveltejs/kit').Config} */
export default {
  extensions: [`.svelte`, `.svx`, `.md`],

  preprocess: [
    preprocess(),
    mdsvex({
      rehypePlugins,
      // remark-math@3.0.0 pinned due to mdsvex, see
      // https://github.com/kwshi/rehype-katex-svelte#usage
      remarkPlugins: [math],
      extensions: [`.svx`, `.md`],
    }),
    importAssets({
      sources: (default_sources) => {
        return [
          ...default_sources,
          {
            tag: `a`,
            srcAttributes: [`href`],
            filter: (node) => node.attributes?.href.endsWith(`.pdf`),
          },
        ]
      },
    }),
  ],

  kit: {
    adapter: adapter(),

    alias: {
      $root: `.`,
    },
  },
}
