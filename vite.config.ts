import adapter from '@sveltejs/adapter-static'
import { sveltekit } from '@sveltejs/kit/vite'
import { create_markdown, markdown } from 'svelte-widgets/markdown'
import { asset_imports } from 'svelte-widgets/assets'
import { default_highlighter } from 'svelte-widgets/highlight'
import { make_config } from 'svelte-widgets/vite-config'
import { yaml_plugin } from 'svelte-widgets/yaml'

const macros: Record<string, string> = {
  // Infinitesimal differential (used in derivatives and integrals)
  '\\dif': `\\mathrm d`,
  '\\vec': `{\\boldsymbol{#1}}`,
  '\\mat': `{\\boldsymbol{#1}}`,
  '\\reals': `{\\mathbb{R}}`,
  '\\comps': `{\\mathbb{C}}`,
  '\\ints': `{\\mathbb{Z}}`,
  '\\expect': `\\mathbb{E}`,
  '\\var': `\\operatorname{var}`,
  '\\diag': `\\operatorname{diag}`,
  '\\unity': `\\mat{\\mathbb{I}}`,
  // Used in equations to hide non-essential constants
  '\\const': `\\text{const}`,
  '\\abs': `\\left|#1\\right|`,
  '\\paren': `\\mathopen{}\\left(#1\\right)\\mathclose{}`,
  '\\brkt': `\\mathopen{}\\left[#1\\right]\\mathclose{}`,
  '\\cbrkt': `\\mathopen{}\\left\\{#1\\right\\}\\mathclose{}`,
}

for (let index = 65; index <= 90; index++) {
  const letter = String.fromCodePoint(index)
  macros[`\\${letter}cal`] = `\\mathcal{${letter}}`
  macros[`\\${letter}bb`] = `\\mathbb{${letter}}`
}

// Inline SvelteKit config: adapter and alias are top-level Kit options.
const svelte_config = {
  extensions: [`.svelte`, `.md`],

  preprocess: [
    markdown(
      create_markdown({
        math: { macros, errorColor: `#cc0000` },
        typography: true,
        highlight: default_highlighter.highlight,
      }),
    ),
    asset_imports(),
  ],

  adapter: adapter(),
  alias: { $root: `.` },
}

export default {
  resolve: { dedupe: [`svelte`] },
  ...make_config(),
  plugins: [sveltekit(svelte_config), yaml_plugin()],

  server: { port: 3000, fs: { allow: [`..`] } },
  preview: { port: 3000 },

  test: {
    include: [`tests/**/*.test.ts`],
    restoreMocks: true,
    unstubGlobals: true,
  },
}
