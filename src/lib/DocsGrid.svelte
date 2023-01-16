<script lang="ts">
  // export let title: string
  // export let files: [string, string][]
</script>

<div class="grid">
  <slot />
</div>

<style>
  div.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
    gap: 2em;
    margin: 1em 0;
  }
  :global(div.grid p) {
    margin: 0;
  }
  :global(div.grid a) {
    text-align: center;
    display: grid;
  }
  :global(div.grid img) {
    width: 100%;
    border-radius: 3pt;
    margin: 0;
  }
</style>
