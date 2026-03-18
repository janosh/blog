<script>
  import pkg from '$root/package.json'
  import Icon from '@iconify/svelte'
  import { ThemeToggle } from 'svelte-multiselect'

  let scroll_y = $state(0)
  let show_scroll_top = $derived(scroll_y > globalThis.innerHeight)
</script>

<svelte:window bind:scrollY={scroll_y} />

{#if show_scroll_top}
  <button onclick={() => document.body.scrollIntoView({ behavior: `smooth` })}>
    <Icon icon="material-symbols:arrow-upward-rounded" />
  </button>
{/if}

<footer>
  <a href={pkg.repository} style="display: flex"><Icon icon="octicon:mark-github" width="20pt" />&ensp;Source</a>
  <ThemeToggle tooltip={false} style="transform: scale(1.4)" />
</footer>

<style>
  footer {
    margin: 3em;
    display: flex;
    place-content: center;
    gap: max(1em, 2vw);
  }
  button {
    position: fixed;
    bottom: 18pt;
    right: 18pt;
    display: flex;
    place-items: center;
    aspect-ratio: 1;
    border-radius: 50%;
    transform: scale(1.4);
  }
  @media print {
    :is(button, footer) {
      display: none;
    }
  }
</style>
