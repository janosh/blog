<script lang="ts">
  import { page } from '$app/state'

  interface Props {
    routes: string[]
  }
  let { routes }: Props = $props()

  let is_current = $derived((url: string) => {
    if (url === page.url.pathname) return `page`
    if (url !== `/` && page.url.pathname.includes(url)) return `page`
    return undefined
  })
</script>

<nav>
  {#each routes as slug, idx (slug)}
    {@const href = `/physics/${slug}`}
    {#if idx > 0}<strong>&bull;</strong>{/if}
    <a {href} aria-current={is_current(href)}>{slug}</a>
  {/each}
</nav>

<style>
  nav {
    display: flex;
    gap: 1em 1ex;
    place-content: center;
    flex-wrap: wrap;
    max-width: 55em;
    margin: 2em auto;
  }
  nav > a {
    padding: 0 4pt;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 3pt;
    transition: 0.2s;
  }
  nav > a[aria-current='page'] {
    color: mediumseagreen;
  }
</style>
