<script lang="ts">
  import { cover_url } from '$lib'
  import { heading_anchors } from 'svelte-widgets'

  let { data, children } = $props()
  let { title, cover, slug } = $derived(data.frontmatter)
</script>

<img
  src={cover_url(`physics`, slug, cover.img)}
  alt={cover.caption ?? title}
  class:thesis-cover={slug === `phd-thesis`}
/>
<h1>{title}</h1>

<main style="max-width: 55em; margin: 1em auto" {@attach heading_anchors()}>
  {@render children?.()}
</main>

<style>
  img {
    margin: 0;
    height: 30vh;
    object-fit: cover;
    width: 100%;
  }
  img.thesis-cover {
    object-position: center 15%;
  }
</style>
