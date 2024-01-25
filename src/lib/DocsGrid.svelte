<script lang="ts">
  export let style: string | null = null
</script>

<div class="grid" {style}>
  <slot />
</div>

<style>
  div.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
    gap: 2em;
    margin: 1em 0;
    text-wrap: balance;
  }
  :global(div.grid p) {
    margin: 0;
  }
  :global(div.grid a) {
    text-align: center;
    display: grid;
    font-size: larger;
    font-weight: bolder;
  }
  :global(div.grid img) {
    width: 100%;
    border-radius: 3pt;
    margin: 0;
  }
</style>
