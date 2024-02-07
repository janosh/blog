<script lang="ts">
  export let label: string = `Sort by`
  export { className as class }
  export let sort_by: string | undefined = undefined
  export let sort_keys: readonly string[] = []
  export let sort_order: 'asc' | 'desc' = `asc`
  export let as: string = `small`
  export let style: string | null = null

  let className: string | null = null
</script>

<svelte:element this={as} class="sort-buttons {className}" {style}>
  {label}
  {#each sort_keys as key}
    <button on:click={() => (sort_by = key)} class:active={sort_by === key}>
      {key}
    </button>
  {/each}
  <button on:click={() => (sort_order = sort_order === `asc` ? `desc` : `asc`)}>
    {sort_order === `asc` ? `↑` : `↓`}
  </button>
</svelte:element>

<style>
  .sort-buttons {
    display: flex;
    gap: 2pt;
    position: absolute;
    right: 0;
    bottom: 4pt;
    font-weight: 100;
    font-size: 9pt;
  }
  .sort-buttons button {
    font-size: 9pt;
    padding: 1pt 2pt;
    border: none;
    color: gray;
    background-color: #f0f0f0;
  }
  .sort-buttons button.active {
    background-color: #e0e0e0;
  }
  @media print {
    .sort-buttons {
      display: none;
    }
  }
</style>
