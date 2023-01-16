<script>
  import Icon from '@iconify/svelte'
</script>

<button on:click={() => document.body.scrollIntoView({ behavior: `smooth` })}>
  <Icon icon="material-symbols:arrow-upward-rounded" />
</button>

<style>
  button {
    position: absolute;
    bottom: 18pt;
    right: 18pt;
    display: flex;
    place-content: center;
    place-items: center;
    width: 18pt;
    height: 18pt;
    border-radius: 50%;
  }
</style>
