<script lang="ts">
  interface Props {
    label?: string
    sort_by?: string
    sort_keys?: readonly string[] | readonly (readonly [string, string])[]
    sort_order?: `asc` | `desc`
    as?: string
    [key: string]: unknown
  }
  let {
    label = `Sort by`,
    sort_by = $bindable(``),
    sort_keys = [],
    sort_order = $bindable(`asc`),
    as = `small`,
    ...rest
  }: Props = $props()
</script>

<svelte:element this={as} aria-label="sort-buttons" {...rest}>
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
  [aria-label='sort-buttons'] {
    display: flex;
    gap: 5pt;
    position: absolute;
    right: 0;
    bottom: 4pt;
    font-weight: 100;
    font-size: 9pt;
  }
  [aria-label='sort-buttons'] button {
    font-size: 9pt;
    padding: 1pt 4pt;
    border: none;
    color: gray;
    background-color: rgba(0, 0, 0, 0.03);
  }
  [aria-label='sort-buttons'] button.active {
    background-color: rgba(0, 0, 0, 0.1);
  }
  @media print {
    [aria-label='sort-buttons'] {
      display: none;
    }
  }
</style>
