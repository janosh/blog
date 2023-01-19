<script lang="ts">
  import { PrevNext } from '$lib'
  import type { LayoutServerData } from '../physics/$types'

  export let data: LayoutServerData

  const routes = Object.keys(import.meta.glob('./*/+page*.{svx,md,svelte}')).map(
    (filename) => filename.split(`/`)[1]
  )

  $: ({ src, caption } = data.frontmatter.cover)
  $: ({ prev, next } = data)
</script>

<img {src} alt={caption} />
<h1>{data.frontmatter.title}</h1>

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
</style>
