<script lang="ts">
  import { repository } from '$root/package.json'
  import { Footer, ThemeToggle } from 'svelte-widgets'
  import { GitHub } from 'svelte-widgets/icons'
</script>

<Footer
  links={[{ href: repository, label: `Source`, icon: GitHub }]}
  style="display: flex; flex-flow: row wrap; place-content: center; place-items: center; gap: var(--footer-nav-gap, 2em); --footer-nav-margin: 0"
>
  <ThemeToggle tooltip={false} style="transform: scale(1.1)" />
</Footer>
