<script lang="ts">
  import { page } from '$app/state'
  import { Icon } from 'svelte-widgets'
  import { GitHub } from 'svelte-widgets/icons'
  import type { Note } from './+layout.server'

  // card for a note: title and first-page thumbnail linking to the PDF, plus a link to its
  // Typst source on GitHub when it has one. `id` lets site search results jump to the card.
  let { file, title }: { file: string; title: string } = $props()
  const note = $derived.by(() => {
    const found: Note | undefined = page.data.notes?.[file]
    // fail the prerender on a misspelled file instead of shipping a broken card
    if (!found) throw new Error(`No note ${file} on ${page.url.pathname}`)
    return found
  })
</script>

<div class="note" id={file}>
  <a href={note.pdf}>{title} <img src={note.thumbnail} alt={title} /></a>
  {#if note.source}
    <a class="source" href={note.source} aria-label="{title} Typst source on GitHub">
      <Icon icon={GitHub} />
    </a>
  {/if}
</div>

<style>
  .note {
    position: relative;
    justify-self: center;
    width: 100%;
    max-width: 360px;
    scroll-margin-top: 2em;
    &:target > a:first-child {
      border-color: var(--link-color);
    }
  }
  .source {
    position: absolute;
    top: 6pt;
    right: 6pt;
    display: flex;
    padding: 3pt;
    border-radius: 50%;
    color: var(--text-secondary);
    &:hover {
      color: var(--link-color);
    }
  }
</style>
