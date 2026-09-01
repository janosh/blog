<script lang="ts">
  import OpenSource from '$lib/OpenSource.svelte'
  import type { PageProps } from './$types'

  const { data }: PageProps = $props()
</script>

<OpenSource projects={data.projects} />
