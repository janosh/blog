<script lang="ts">
  import { cover_url, type PageMeta } from '#lib'

  let { section, title, slug, cover }: PageMeta & { section: `posts` | `physics` } =
    $props()
</script>

<!-- clicking a captioned cover pops up its caption, which says what the image shows -->
<svelte:element
  this={cover.caption ? `button` : `div`}
  popovertarget={cover.caption && `cover-note`}
>
  <img src={cover_url(section, slug, cover.img)} alt={cover.caption ?? title} />
</svelte:element>
{#if cover.caption}<p id="cover-note" popover>{cover.caption}</p>{/if}
{#if cover.origin}
  <small class="credit">
    Cover: {#if cover.url}<a href={cover.url}>{cover.origin}</a>{:else}{cover.origin}{/if}
  </small>
{/if}

<style>
  button {
    display: block;
    width: 100%;
    padding: 0;
    border-radius: 0;
    anchor-name: --cover;
  }
  img {
    display: block;
    margin: 0;
    width: 100%;
    height: var(--cover-height, min(45vh, 70vw));
    object-fit: cover;
    object-position: var(--cover-position, center);
    background: linear-gradient(-45deg, var(--card-bg), var(--nav-bg), var(--border));
  }
  [popover] {
    position-anchor: --cover;
    position-area: center;
    align-self: end;
    max-width: min(40em, 100% - 2em);
    margin: 0 0 1em;
    padding: 0.5em 0.9em;
    border: none;
    border-radius: var(--radius-sm);
    background: color-mix(in srgb, var(--page-bg) 82%, transparent);
    backdrop-filter: blur(8px);
    color: var(--text-color);
    font-size: 0.9em;
  }
</style>
