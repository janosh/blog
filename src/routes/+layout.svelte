<script lang="ts">
  import { goto } from '$app/navigation'
  import { page } from '$app/state'
  import { Footer } from '$lib'
  import { type Snippet } from 'svelte'
  import { CmdPalette, CopyButton } from 'svelte-multiselect'
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
</script>

<CmdPalette {actions} placeholder="Go to..." />
<CopyButton global />

{#if page.url.pathname !== `/`}
  <a href="/" aria-label="Back to index page">&larr; home</a>
{/if}

{@render children?.()}

{#if page.url.pathname !== `/cv`}
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
