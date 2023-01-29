<script lang="ts">
  import { PrevNext } from '$lib'
  import { repository } from '$root/package.json'
  import Icon from '@iconify/svelte'
  import type { LayoutServerData } from '../physics/$types'

  export let data: LayoutServerData

  $: ({ post, prev, next } = data)
  $: ({ title, cover, date, slug } = post)
</script>

<img
  src="{repository}/raw/main/src/routes/posts/{slug}/{cover.img}"
  alt={cover.caption}
/>
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
  }
  time {
    text-align: center;
  }
</style>
