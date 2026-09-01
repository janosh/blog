<script lang="ts">
  import { dev } from '$app/environment'
  import { afterNavigate, goto } from '$app/navigation'
  import { page } from '$app/state'
  import { cover_url, Footer } from '$lib'
  import { search_actions } from '$lib/search'
  import { homepage, repository } from '$root/package.json'
  import { CopyButton, GitHubCorner, PageSearch, Toc } from 'svelte-widgets'
  import { highlight_matches } from 'svelte-widgets/attachments'
  import type { LayoutProps } from './$types'
  // oxlint-disable-next-line no-unassigned-import
  import '../app.css'
  // KaTeX CSS must match the version rendering the Markdown math.
  // oxlint-disable-next-line no-unassigned-import
  import 'katex/dist/katex.min.css'

  let { children }: LayoutProps = $props()

  let page_search_query = $state(``)
  const section_titles: Record<string, string> = {
    '/posts': `Posts`,
    '/physics': `Physics`,
    '/open-source': `Open Source`,
    '/cv': `CV`,
  }

  const site_description = `I write about physics, materials science and sustainability.`
  // post or physics frontmatter of the current page (undefined on index/list pages)
  const frontmatter = $derived(page.data.post ?? page.data.frontmatter)
  const title = $derived(section_titles[page.route.id ?? ``] ?? frontmatter?.title)
  const page_title = $derived(title ? `${title} · janosh.dev` : `janosh.dev`)
  const og_image = $derived.by(() => {
    if (!frontmatter) return `${homepage}/favicon.svg`
    const section = page.data.post ? `posts` : `physics`
    return new URL(cover_url(section, frontmatter.slug, frontmatter.cover.img), homepage)
      .href
  })

  // pagefind only exists after build; stub in dev to avoid HTML-as-JS reimports
  const load_pagefind = dev ? async () => ({ search: async () => null }) : undefined

  afterNavigate(() => (page_search_query = ``))
</script>

<svelte:head>
  <title>{page_title}</title>
  <meta data-pagefind-meta="title[content]" content={page_title} />
  <meta name="description" content={site_description} />
  <meta property="og:site_name" content="janosh.dev" />
  <meta property="og:type" content={page.data.post ? `article` : `website`} />
  <meta property="og:title" content={page_title} />
  <meta property="og:description" content={site_description} />
  <meta property="og:url" content={`${homepage}${page.url.pathname}`} />
  <meta property="og:image" content={og_image} />
  <meta name="twitter:card" content="summary_large_image" />
  {#if page.data.post}
    <meta property="article:published_time" content={page.data.post.date} />
    {#each page.data.post.tags as tag (tag)}
      <meta property="article:tag" content={tag} />
    {/each}
  {/if}
</svelte:head>

<PageSearch
  fallback_actions={search_actions}
  {load_pagefind}
  navigate={async (url, { query }) => {
    await goto(url)
    page_search_query = ``
    queueMicrotask(() => (page_search_query = query))
  }}
  strip_html_suffix
  placeholder="Search or go to..."
  input_style="background: transparent; font-size: inherit; outline: none; border: none"
  li_option_style="padding: 3pt 5pt; border-left: none"
  ul_options_style="padding: 0"
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
  {@render children()}
</div>

{#if page.url.pathname !== `/cv`}
  <Toc
    dynamic
    heading_selector="main :where(h2, h3)"
    breakpoint={1100}
    min_items={3}
    open_button_props={{ style: `display: flex; padding: 3px;` }}
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
