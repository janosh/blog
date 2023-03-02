<script lang="ts">
  import { dev } from '$app/environment'
  import { PrevNext } from '$lib'
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import type { LayoutServerData } from '../physics/$types'

  export let data: LayoutServerData

  $: ({ post, prev, next } = data)
  $: ({ title, cover, date, slug } = post)
</script>

{#if dev}
  {#await import(`./${slug}/${cover.img}`) then { default: src }}
    <img {src} alt={title} />
  {/await}
{:else}
  <img
    src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
    alt={cover.caption}
  />
{/if}

<h1>{title}</h1>
<time>
  <Icon icon="carbon:calendar" inline />
  {date.split(`T`)[0]}
</time>
<main>
  <slot />

  <PrevNext {prev} {next} />
</main>

<style>
  img {
    margin: 0;
    height: 50vh;
    object-fit: cover;
    background: linear-gradient(-45deg, #5a6323, #2a355e, #642626);
  }
  time {
    text-align: center;
  }
</style>
