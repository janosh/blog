<script lang="ts">
  import { afterNavigate, goto } from '$app/navigation'
  import { page } from '$app/stores'
  import { Footer } from '$lib'
  import { mount, type Snippet } from 'svelte'
  import { CmdPalette } from 'svelte-multiselect'
  import { CopyButton } from 'svelte-zoo'
  import '../app.css'

  interface Props {
    children?: Snippet
  }
  let { children }: Props = $props()

  const actions = Object.keys(import.meta.glob(`./**/+page.{svx,svelte,md}`)).map(
    (filename) => {
      const parts = filename.split(`/`).filter((part) => !part.startsWith(`(`)) // remove hidden route segments
      const route = `/${parts.slice(1, -1).join(`/`)}`
      return { label: route, action: () => goto(route) }
    },
  )
  const code_btn_style = `position: absolute; top: 1ex; right: 1ex;`

  afterNavigate(() => {
    for (const node of document.querySelectorAll(`pre > code`)) {
      // skip if <pre> already contains a button (presumably for copy)
      const pre = node.parentElement
      if (!pre || pre.querySelector(`button`)) continue

      mount(CopyButton, {
        target: pre,
        props: { content: node.textContent ?? ``, style: code_btn_style },
      })
    }
  })
</script>

<CmdPalette {actions} placeholder="Go to..." />

{#if $page.url.pathname !== `/`}
  <a href="/" aria-label="Back to index page">&larr; home</a>
{/if}

{@render children?.()}

{#if $page.url.pathname !== `/cv`}
  <Footer />
{/if}

<style>
  a[href='/'] {
    font-size: 14pt;
    position: absolute;
    top: 2em;
    left: 2em;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 1pt 5pt;
    border-radius: 3pt;
    transition: 0.2s;
  }
  @media print {
    a[href='/'] {
      display: none;
    }
  }
</style>
