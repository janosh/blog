<script lang="ts">
  import { dev } from '$app/environment'
  import { page } from '$app/state'
  import type { FrontMatter } from '$lib'
  import { repository } from '$root/package.json'
  import type { Snippet } from 'svelte'
  import { heading_anchors, Icon, PrevNext } from 'svelte-widgets'
  import { Calendar } from 'svelte-widgets/icons'
  import type { PageData } from '../$types'

  let { data, children }: { data: PageData; children?: Snippet<[]> } = $props()

  let post = $derived.by(() => {
    if (!data.post) throw new Error(`Post ${page.url.pathname} not found`)
    return data.post
  })
  let { title, cover, date, slug } = $derived(post)
</script>

{#if dev}
  {#await import(`./${slug}/${cover?.img?.replace(`.svg`, ``)}.svg`) then svg}
    <img src={svg.default} alt={cover?.caption} />
  {/await}
{:else}
  <img
    src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
    alt={cover.caption}
  />
{/if}

<main style="max-width: 50em; margin: 0 auto" {@attach heading_anchors()}>
  <h1>{title}</h1>
  <time>
    <Icon icon={Calendar} />
    {date?.split(`T`)[0]}
  </time>
  {@render children?.()}

  <br />
  <PrevNext items={data.posts.map((post) => [post.slug, post])} current={slug}>
    {#snippet children({ item, kind })}
      {@const { slug, title, date } = item[1] as FrontMatter}
      <h3 class="toc-exclude">
        <a href={slug}>
          {@html kind == `next` ? `Next &rarr;` : `&larr; Previous`}
          <br />
          <small>{title}</small>
        </a>
        <br />
        <time>{new Date(date).toISOString().split?.(`T`)[0]}</time>
      </h3>
    {/snippet}
  </PrevNext>
</main>

<style>
  img {
    margin: 0;
    height: 50vh;
    width: 100%;
    object-fit: cover;
    background: linear-gradient(-45deg, var(--card-bg), var(--nav-bg), var(--border));
  }
  time {
    font-weight: lighter;
    font-size: 10pt;
    text-align: center;
    display: block;
  }
</style>
