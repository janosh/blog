<script lang="ts">
  interface Props {
    label?: string
    sort_by?: string | undefined
    sort_keys?: readonly string[]
    sort_order?: `asc` | `desc`
    as?: string
    style?: string | null
    class?: string | null
  }
  let {
    label = `Sort by`,
    sort_by = $bindable(undefined),
    sort_keys = [],
    sort_order = $bindable(`asc`),
    as = `small`,
    style = null,
    class: className = null,
  }: Props = $props()
</script>

<svelte:element this={as} class="sort-buttons {className}" {style}>
  {label}
  {#each sort_keys as key (key)}
    {@const [name, title] = Array.isArray(key) ? key : [key, key]}
    <button onclick={() => (sort_by = name)} class:active={sort_by === name} {title}>
      {name}
    </button>
  {/each}
  <button onclick={() => (sort_order = sort_order === `asc` ? `desc` : `asc`)}>
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
