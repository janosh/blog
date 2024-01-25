<script lang="ts">
  import { repository } from '$root/package.json'

  export let data

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
    height: 30vh;
    object-fit: cover;
    width: 100%;
  }
</style>
