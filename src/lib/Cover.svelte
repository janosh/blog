<script lang="ts">
  import { cover_url, type PageMeta } from '#lib'

  let { section, title, slug, cover }: PageMeta & { section: `posts` | `physics` } =
    $props()
</script>

<img src={cover_url(section, slug, cover.img)} alt={cover.caption ?? title} />
{#if cover.origin}
  <small class="credit">
    Cover: {#if cover.url}<a href={cover.url}>{cover.origin}</a>{:else}{cover.origin}{/if}
  </small>
{/if}

<style>
  img {
    margin: 0;
    width: 100%;
    height: var(--cover-height, 30vh);
    object-fit: cover;
    object-position: var(--cover-position, center);
    background: linear-gradient(-45deg, var(--card-bg), var(--nav-bg), var(--border));
  }
</style>
