<script lang="ts">
  import type { LayoutServerData } from '../physics/$types'

  export let data: LayoutServerData

  const routes = Object.keys(import.meta.glob('./*/+page*.{svx,md,svelte}')).map(
    (filename) => filename.split(`/`)[1]
  )

  $: ({ src, caption } = data.frontmatter.cover)
</script>

<img {src} alt={caption} />
<h1>{data.frontmatter.title}</h1>

<main>
  <slot />
</main>

<style>
  img {
    margin: 0;
    height: 50vh;
    object-fit: cover;
  }
</style>
