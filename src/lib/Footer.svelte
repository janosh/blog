<script lang="ts">
  import { repository } from '$root/package.json'
  import { Footer, ThemeToggle } from 'svelte-widgets'
</script>

<Footer links={[{ href: repository, label: `Source`, icon: `GitHub` }]}>
  <ThemeToggle tooltip={false} style="transform: scale(1.4)" />
</Footer>
