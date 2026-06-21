<script lang="ts">
  import { dev } from '$app/environment'
  import { repository } from '$root/package.json'
  import { heading_anchors } from 'svelte-multiselect'

  let { data, children } = $props()
  let { title, cover, slug } = $derived(data.frontmatter)

  const local_covers = import.meta.glob<string>(`./*/*.{avif,jpg,jpeg,png,svg,webp}`, {
    eager: true,
    import: `default`,
  })

  let cover_src = $derived(
    cover.img.startsWith(`http`)
      ? cover.img
      : (dev && local_covers[`./${slug}/${cover.img}`]) ||
          `${repository}/raw/main/src/routes/physics/${slug}/${cover.img}`,
  )
</script>

<img src={cover_src} alt={cover.caption} class:thesis-cover={slug === `phd-thesis`} />
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
