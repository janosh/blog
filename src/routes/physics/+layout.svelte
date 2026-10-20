<script lang="ts">
  import { Cover } from '#lib'
  import { heading_anchors } from 'svelte-widgets'
  import type { LayoutProps } from './$types'

  let { data, children }: LayoutProps = $props()
</script>

<Cover section="physics" {...data.frontmatter} />
<h1>{data.frontmatter.title}</h1>

<main style="max-width: 55em; margin: 1em auto" {@attach heading_anchors()}>
  {@render children()}
</main>
