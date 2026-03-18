<script lang="ts">
  import { goto } from '$app/navigation'
  import { page } from '$app/state'
  import { Footer } from '$lib'
  import type { Snippet } from 'svelte'
  import { CmdPalette, CopyButton } from 'svelte-multiselect'
  import '../app.css'

  let { children }: { children?: Snippet<[]> } = $props()

  function set_theme(mode: 'light' | 'dark' | 'system') {
    const scheme = mode === `system`
      ? (matchMedia(`(prefers-color-scheme: dark)`).matches ? `dark` : `light`)
      : mode
    document.documentElement.style.colorScheme = scheme
    document.documentElement.dataset.theme = scheme
    localStorage.setItem(`theme`, mode)
  }

  const actions = [
    ...Object.keys(import.meta.glob(`./**/+page.{svx,svelte,md}`)).map((filename) => {
      const parts = filename.split(`/`).filter((part) => !part.startsWith(`(`))
      const route = `/${parts.slice(1, -1).join(`/`)}`
      return { label: route, action: () => goto(route) }
    }),
    { label: `🌞 Light theme`, action: () => set_theme(`light`) },
    { label: `🌙 Dark theme`, action: () => set_theme(`dark`) },
    { label: `🖥️ System theme`, action: () => set_theme(`system`) },
  ]
</script>

<CmdPalette
  {actions}
  placeholder="Go to..."
  inputStyle="background: transparent; font-size: inherit"
  liOptionStyle="padding: 3pt 5pt; border-left: none"
  ulOptionsStyle="padding: 0"
/>
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
    background-color: var(--card-bg);
    padding: 1pt 5pt;
    border-radius: 3pt;
    transition: color 0.2s;
  }
  @media print {
    a[href='/'] {
      display: none;
    }
  }
</style>
