<script lang="ts">
  import type { Snippet } from 'svelte'
  import type { HTMLAttributes } from 'svelte/elements'

  let { children, ...rest }: { children?: Snippet } & HTMLAttributes<HTMLDivElement> =
    $props()
</script>

<div class="docs-grid" {...rest}>
  {@render children?.()}
</div>
