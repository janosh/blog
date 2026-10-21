import adapter from '@sveltejs/adapter-static'
import { sveltekit } from '@sveltejs/kit/vite'
import { create_markdown } from 'svelte-widgets/markdown'
import { markdown_vite } from 'svelte-widgets/markdown/vite'
import { asset_imports } from 'svelte-widgets/assets'
import { default_highlighter } from 'svelte-widgets/highlight'
import { make_config } from 'svelte-widgets/vite-config'
import { yaml_plugin } from 'svelte-widgets/yaml'
import { homepage } from './package.json' with { type: 'json' }

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

// markdown_vite also serves `page.md?metadata` imports (frontmatter as JSON, no compile)
const docs = markdown_vite(
  create_markdown({
    math: { macros, errorColor: `#cc0000` },
    typography: true,
    highlight: default_highlighter.highlight,
  }),
)

const svelte_config = {
  extensions: [`.svelte`, `.md`],
  preprocess: [docs.preprocess, asset_imports()],
  adapter: adapter(),
  // lets the prerender crawler follow absolute og:image URLs (e.g. PNG copies of SVG covers)
  paths: { origin: homepage },
}

export default {
  ...make_config(),
  plugins: [sveltekit(svelte_config), docs.plugin, yaml_plugin()],
  server: { port: 3000 },
  preview: { port: 3000 },
  test: {
    include: [`tests/**/*.test.ts`],
    restoreMocks: true,
    unstubGlobals: true,
  },
}
