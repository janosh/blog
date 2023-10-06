<script>
  import { repository as repo } from '$root/package.json'
  import Icon from '@iconify/svelte'
</script>

<button on:click={() => document.body.scrollIntoView({ behavior: `smooth` })}>
  <Icon icon="material-symbols:arrow-upward-rounded" />
</button>

<footer>
  <a href={repo}><Icon icon="octicon:mark-github" width="20pt" />Source</a>
</footer>

<style>
  footer {
    margin: 3em;
  }
  footer a {
    display: flex;
    place-content: center;
    gap: 5pt;
  }
  button {
    position: absolute;
    bottom: 18pt;
    right: 18pt;
    display: flex;
    place-items: center;
    aspect-ratio: 1;
    border-radius: 50%;
    transform: scale(1.4);
  }
</style>
