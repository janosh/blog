import adapter from '@sveltejs/adapter-static'
import type { Config } from '@sveltejs/kit'
import { mdsvex } from 'mdsvex'
import { importAssets } from 'svelte-preprocess-import-assets'
import { heading_ids } from 'svelte-widgets/heading-anchors'
import { katex_preprocess } from 'svelte-widgets/katex'
import { starry_night_highlighter } from 'svelte-widgets/live-examples'

const macros: Record<string, string> = {
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

for (let index = 65; index <= 90; index++) {
  const letter = String.fromCodePoint(index)
  // Caligraphic letters
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  // Blackboard bold letters
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

const katex = katex_preprocess({ macros, errorColor: `#cc0000` })

export default {
  extensions: [`.svelte`, `.svx`, `.md`],

  preprocess: [
    katex.before,
    mdsvex({
      extensions: [`.svx`, `.md`],
      highlight: { highlighter: starry_night_highlighter },
    }),
    katex.after,
    heading_ids(),
    importAssets({
      sources: (default_sources) => [
        ...default_sources,
        {
          tag: `a`,
          srcAttributes: [`href`],
          filter: ({ attributes }) => attributes.href.endsWith(`.pdf`),
        },
      ],
    }),
  ],

  kit: {
    adapter: adapter(),

    alias: {
      $root: `.`,
    },
  },
} satisfies Config
