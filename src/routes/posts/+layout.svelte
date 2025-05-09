<script lang="ts">
  import { dev } from '$app/environment'
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import type { Snippet } from 'svelte'
  import { PrevNext } from 'svelte-zoo'
  import type { PageData } from '../$types'

  interface Props {
    data: PageData
    children: Snippet
  }
  let { data, children }: Props = $props()
  let { title, cover, date, slug } = $derived(data.post)
</script>

{#if dev}
  {#await import(`./${slug}/${cover?.img?.replace(`.svg`, ``)}.svg`) then { default: src }}
    <img {src} alt={cover?.caption} />
  {/await}
{:else}
  <img
    src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
    alt={cover.caption}
  />
{/if}

<h1 style="margin: 2em 0 1em;">{title}</h1>
<time>
  <Icon icon="carbon:calendar" inline />
  {date?.split(`T`)[0]}
</time>
<main style="max-width: 50em;">
  {@render children?.()}

  <br />
  <PrevNext items={data.posts.map((post) => [post.slug, post])} current={slug}>
    {#snippet children({ item, kind })}
      <h3>
        <a href={item.slug}>
          {@html kind == `next` ? `Next &rarr;` : `&larr; Previous`}
          <br />
          <small>{item.title}</small>
        </a>
        <br />
        <time>{new Date(item.date).toISOString().split?.(`T`)[0]}</time>
      </h3>
    {/snippet}
  </PrevNext>
</main>

<style>
  img {
    margin: 0;
    height: 50vh;
    object-fit: cover;
    background: linear-gradient(-45deg, #5a6323, #2a355e, #642626);
  }
  time {
    font-weight: lighter;
    font-size: 10pt;
    text-align: center;
  }
</style>
