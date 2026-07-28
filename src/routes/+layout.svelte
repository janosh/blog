<script lang="ts">
  import { dev } from '$app/environment'
  import { afterNavigate, goto } from '$app/navigation'
  import { page } from '$app/state'
  import { Footer } from '$lib'
  import { repository } from '$root/package.json'
  import type { Snippet } from 'svelte'
  import { CopyButton, GitHubCorner, PageSearch, Toc } from 'svelte-widgets'
  import { highlight_matches } from 'svelte-widgets/attachments'
  import { apply_theme_mode } from 'svelte-widgets/theme'
  // oxlint-disable-next-line no-unassigned-import
  import '../app.css'

  let { children }: { children?: Snippet<[]> } = $props()

  let page_search_query = $state(``)
  const section_titles: Record<string, string> = {
    '/posts': `Posts`,
    '/physics': `Physics`,
    '/open-source': `Open Source`,
    '/cv': `CV`,
  }

  const page_title = $derived.by(() => {
    const title =
      section_titles[page.route.id ?? ``] ??
      page.data.post?.title ??
      (page.data.frontmatter as { title?: string } | undefined)?.title
    return typeof title === `string` ? `${title} · janosh.dev` : `janosh.dev`
  })

  const fallback_actions = [
    ...Object.keys(import.meta.glob(`./**/+page.{svx,svelte,md}`)).map((filename) => {
      const parts = filename.split(`/`).filter((part) => !part.startsWith(`(`))
      const route = `/${parts.slice(1, -1).join(`/`)}`
      return { label: route, action: () => goto(route) }
    }),
    { label: `🌞 Light theme`, action: () => apply_theme_mode(`light`) },
    { label: `🌙 Dark theme`, action: () => apply_theme_mode(`dark`) },
    { label: `🖥️ System theme`, action: () => apply_theme_mode(`system`) },
  ]

  // pagefind only exists after build; stub in dev to avoid HTML-as-JS reimports
  const load_pagefind = dev ? async () => ({ search: async () => null }) : undefined

  afterNavigate(() => (page_search_query = ``))
</script>

<svelte:head>
  <title>{page_title}</title>
  <meta data-pagefind-meta="title[content]" content={page_title} />
</svelte:head>

<PageSearch
  {fallback_actions}
  {load_pagefind}
  navigate={async (url, { query }) => {
    await goto(url)
    page_search_query = ``
    queueMicrotask(() => (page_search_query = query))
  }}
  strip_html_suffix
  placeholder="Search or go to..."
  inputStyle="background: transparent; font-size: inherit; outline: none; border: none"
  liOptionStyle="padding: 3pt 5pt; border-left: none"
  ulOptionsStyle="padding: 0"
/>
<CopyButton global />
<GitHubCorner href={repository} data-github-corner />

{#if page.url.pathname !== `/`}
  <a href="/" aria-label="Back to index page">&larr; home</a>
{/if}

<div
  data-pagefind-body
  style="display: contents"
  {@attach highlight_matches({
    query: page_search_query,
    css_class: `page-search-match`,
    duration_ms: 8000,
  })}
>
  {@render children?.()}
</div>

{#if page.url.pathname !== `/cv`}
  <Toc
    headingSelector="main :where(h2, h3)"
    breakpoint={1100}
    minItems={3}
    openButtonProps={{ style: `display: flex; padding: 3px;` }}
    --toc-mobile-bg="var(--card-bg)"
    --toc-padding="1em 0 1em 1em"
    --toc-active-color="var(--link-color)"
  />
  <Footer />
{/if}

<style>
  a[href='/'] {
    font-size: 14pt;
    position: absolute;
    top: 2em;
    left: 2em;
    background-color: color-mix(in srgb, var(--card-bg) 85%, transparent);
    backdrop-filter: blur(8px);
    border: 1px solid var(--card-border);
    padding: 2pt 8pt;
    border-radius: var(--radius-md);
  }
  :global(aside.toc.desktop) {
    position: fixed;
    top: 5em;
    right: 1em;
    font-size: 0.75rem;
    max-width: 14rem;
  }
  @media print {
    a[href='/'],
    :global([data-github-corner]),
    :global(footer),
    :global(aside.toc) {
      display: none;
    }
  }
</style>
