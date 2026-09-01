<script lang="ts">
  import { when_visible } from '$lib'
  import type { AnyStructure } from 'matterviz/structure'
  import { slugify_heading } from 'svelte-widgets/heading-anchors'

  let { structure, title }: { structure: AnyStructure; title: string } = $props()
  let visible = $state(false)
</script>

<section {@attach when_visible(() => (visible = true))}>
  <h2 id={slugify_heading(title)}>{title}</h2>
  <div style="height: 500px">
    {#if visible}
      {#await import(`matterviz/structure`)}
        <p role="status">Loading 3D structure viewer...</p>
      {:then { Structure }}
        <Structure {structure} --struct-bg-fullscreen="var(--page-bg)" />
      {:catch error}
        <p role="alert">Could not load the 3D viewer: {String(error)}</p>
      {/await}
    {:else}
      <p>3D structure viewer loads when scrolled into view.</p>
    {/if}
  </div>
</section>
