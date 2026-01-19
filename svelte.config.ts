import adapter from '@sveltejs/adapter-static'
import type { Config } from '@sveltejs/kit'
import { mdsvex } from 'mdsvex'
import katex from 'rehype-katex-svelte'
import math from 'remark-math'
import { heading_ids } from 'svelte-multiselect/heading-anchors'
import preprocess from 'svelte-preprocess'
import { importAssets } from 'svelte-preprocess-import-assets'

const macros = {
  // Infinitesimal differential (used in derivatives and integrals)
  '\\dif': `\\mathrm d`,
  // Vector
  '\\vec': `#1`, // TODO restore {\\boldsymbol{#1}} causing deno build error
  // Matrix
  '\\mat': `#1`, // TODO restore {\\boldsymbol{#1}} causing deno build error
  // Real line
  '\\reals': `{\\mathbb{R}}`,
  // Complex plane
  '\\comps': `{\\mathbb{C}}`,
  // Integers
  '\\ints': `{\\mathbb{Z}}`,
  // Expectation value
  '\\expect': `\\mathbb{E}`,
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

export default {
  extensions: [`.svelte`, `.svx`, `.md`],

  preprocess: [
    preprocess(),
    mdsvex({
      rehypePlugins: [
        [katex, { macros, throwOnError: false, errorColor: `#cc0000` }],
      ] as Plugin[],
      // remark-math@3.0.0 pinned due to mdsvex, see
      // https://github.com/kwshi/rehype-katex-svelte#usage
      remarkPlugins: [math],
      extensions: [`.svx`, `.md`],
    }),
    heading_ids(),
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
} satisfies Config
