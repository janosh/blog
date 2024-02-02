<script lang="ts">
  import type { Reference } from '$lib'
  import { highlight_matches } from 'svelte-zoo'
  import { truncate_authors } from '.'

  export let references: Reference[]
  export let first_name_mode: 'initial' | 'full' | 'none' = `initial`
  export let target_author: string = `J. Riebesell`
</script>

<ol
  use:highlight_matches={{
    query: target_author.toLowerCase(),
    css_class: `highlight-match`,
  }}
>
  {#each references.sort(({ author }) => {
    return -(author[0].family == target_author.split(` `)[1])
  }) as { title, id, author, DOI, URL: href, issued } (id)}
    {@const author_str = author
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
        {@html truncate_authors(author_str, target_author)}
      </span>
      <small>
        &mdash;
        {#if DOI}
          <a href="https://doi.org/{DOI}">{DOI}</a>
        {:else if href}
          <a {href}>{href.replace(`https://`, ``)}</a>
        {/if}
        {#if issued}
          &mdash; {issued[0].year}-{issued[0].month}
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
  ::highlight(highlight-match) {
    color: initial;
  }
</style>
