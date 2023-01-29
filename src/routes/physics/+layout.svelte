<script lang="ts">
  import { repository } from '$root/package.json'
  import type { LayoutServerData } from './$types'

  export let data: LayoutServerData

  const routes = Object.keys(import.meta.glob('./*/+page*.{svx,md,svelte}')).map(
    (filename) => filename.split(`/`)[1]
  )

  $: ({ cover, slug } = data.frontmatter)
</script>

<img
  src="{repository}/raw/main/src/routes/physics/{slug}/{cover.img}"
  alt={cover.caption}
/>
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
