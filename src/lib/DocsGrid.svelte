<script lang="ts">
  import type { Snippet } from 'svelte'
  import type { HTMLAttributes } from 'svelte/elements'

  let { children, ...rest }: HTMLAttributes<HTMLDivElement> & {
    children?: Snippet<[{ idx: number }]>
  } = $props()
</script>

<div class="grid" {...rest}>
  {@render children?.()}
</div>

<style>
  div.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 1.5em;
  }
  div.grid :global(a) {
    text-align: center;
    display: grid;
    font-weight: bold;
    color: inherit;
    padding: 8pt 5pt;
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: 8pt;
  }
  div.grid :global(a:hover) {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px var(--shadow);
  }
  div.grid :global(img) {
    width: 100%;
    object-fit: cover;
    border-radius: 3pt;
    margin: 0;
  }
</style>
