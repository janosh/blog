<script lang="ts">
  import { social } from '#lib/social.js'
  import { repository } from '#root/package.json'
  import { Footer, Icon, ThemeToggle } from 'svelte-widgets'
  import { GitHub, RSS } from 'svelte-widgets/icons'

  const profiles = [
    ...social,
    { name: `RSS feed`, url: `/rss.xml`, icon: RSS, style: `` },
  ]
</script>

<Footer
  links={[{ href: repository, label: `Source`, icon: GitHub }]}
  style="display: flex; flex-flow: row wrap; place-content: center; place-items: center; gap: var(--footer-nav-gap, 2em); --footer-nav-margin: 0"
>
  <span class="profiles">
    {#each profiles as { name, url, icon, style } (url)}
      <a href={url} title={name} aria-label={name}><Icon {icon} {style} /></a>
    {/each}
  </span>
  <ThemeToggle tooltip={false} style="transform: scale(1.1)" />
</Footer>

<style>
  .profiles {
    display: flex;
    gap: 1em;
    font-size: 1.1em;
  }
</style>
