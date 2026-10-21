<script lang="ts">
  import { social } from '#lib/social.js'
  import { repository } from '#root/package.json'
  import { Footer, Icon, ThemeToggle } from 'svelte-widgets'
  import { GitHub, RSS } from 'svelte-widgets/icons'

  // RSS glyph fills only 16 of its 24 viewBox units, so scale it up to match its neighbors
  const profiles = [
    ...social,
    { name: `RSS feed`, url: `/rss.xml`, icon: RSS, style: `transform: scale(1.3);` },
  ]
</script>

<Footer
  links={[{ href: repository, label: `Source`, icon: GitHub }]}
  style="display: flex; flex-flow: row wrap; place-content: center; place-items: center; gap: clamp(0.5em, 3vw, 1.4em); --footer-nav-margin: 0"
>
  <span class="profiles">
    {#each profiles as { name, url, icon, style } (url)}
      <a href={url} title={name} aria-label={name}><Icon {icon} {style} /></a>
    {/each}
  </span>
  <!-- ThemeToggle scales its icon by 1.5 internally, too big next to the profile icons -->
  <ThemeToggle tooltip={false} icon_props={{ style: `transform: scale(1.15)` }} />
</Footer>

<style>
  .profiles {
    display: flex;
    align-items: center;
    gap: clamp(0.5em, 2.5vw, 0.9em);
    font-size: 1.25em;
    padding: 0 clamp(0.5em, 3vw, 1.1em);
    border-inline: 1px solid color-mix(in srgb, currentColor 25%, transparent);
    a {
      display: inline-flex;
    }
  }
</style>
