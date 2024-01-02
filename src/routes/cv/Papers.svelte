<script lang="ts">
  import type { Reference } from '$lib'
  import { truncate_authors } from './utils'

  export let references: Reference[]
  export let first_name_mode: 'initial' | 'full' | 'none' = `full`
  export let target_author = `Janosh Riebesell`
</script>

<ol>
  {#each references.sort(({ author }) => {
    return +(author[0].family == target_author.split(` `)[1])
  }) as { title, id, author, DOI, URL: href, issued } (id)}
    {@const authors = author
      .map(({ given, family }) => {
        const first_name = {
          initial: `${given[0]}. `,
          full: `${given} `,
          none: ``,
        }[first_name_mode]
        return `${first_name ?? ``}${family}`
      })
      .join(`, `)}
    <li>
      <h3 {id}>{title}</h3>
      <span>
        {truncate_authors(authors, target_author)}
      </span>
      <small>
        &mdash;
        {#if DOI}
          <a href="https://doi.org/{DOI}">{DOI}</a>
        {:else if href}
          <a {href}>{href}</a>
        {/if}
        {#if issued}
          &mdash; {issued[0].year}
        {/if}
      </small>
    </li>
  {/each}
</ol>

<style>
  ol {
    list-style: none;
    padding: 0;
  }
  ol > li {
    font-size: 10pt;
    font-weight: 300;
  }
  ol > li > h3 {
    margin: 8pt 0 2pt;
    font-size: small;
  }
</style>
